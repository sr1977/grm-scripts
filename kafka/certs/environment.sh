function gen_kafka_certs { (
    set -e
    if [ -z $1 ]; then
	    echo "Usage $0 <cn> <namespace> <cluster> <squad> <keystore_filename> <keystore_password> <cert_prefix_in_keystore>"
        echo "CN has to be passed"
        echo "Go to https://stash.skybet.net/projects/PS/repos/kafka-pki-tooling/browse/README.md for parameters"
	    return 1
    fi

    CN="$1"
    NAMESPACE="$2"
    ENV="${2:-test}"
    CLUSTER="${3:-trading}"
    SQUAD="${4-gstp-risk-management}"
    KEYSTORE_FILE="${5:-keystore.jks}"
    KEYSTORE_PASSWORD="${6:-`pwgen 16 1`}"
    CERT_PREFIX="${7:-trading}"

    case "$NAMESPACE" in
        "live" | "nps")
            ENV=prod
            ;;
        *)
            ENV=test
            ;;
    esac

    SECRET_PATH="secret/trading/gbm/${NAMESPACE}/$1/kafka"
    KEYSTORE_DESTINATION="$(pwd)/$(basename $KEYSTORE_FILE)"

    if [ -f "$KEYSTORE_DESTINATION" ]; then
        echo "Archiving previous keystore"
        mv -v $KEYSTORE_DESTINATION ${KEYSTORE_DESTINATION}.prev
    fi

    WORK_DIR=$(mktemp -d)
    if [ -f "$KEYSTORE_FILE" ]; then
        echo "Keystore exists appending cert to it"
        cp $KEYSTORE_FILE $WORK_DIR
    else
        echo "Keystore does not exist, creating new one"
    fi
    cd $WORK_DIR

    echo "Working directory: $WORK_DIR"
    echo "CERT COMMON NAME (CN): $CN"
    echo "Environment: $ENV"
    echo "Keystore filename: $KEYSTORE_FILE"
    echo "Keystore password: $KEYSTORE_PASSWORD"
    
    echo "Generating cert for cluster $CLUSTER, squad $SQUAD, env $ENV"
    pscli vault -- write -format=json ps-pki/kafka/$CLUSTER/$ENV/issue/$SQUAD common_name="$CN" ttl=131490h > output.json

    echo "Generating cert files"
    jq -r '.data .ca_chain[0]' output.json > ca-chain0.crt
    jq -r '.data .ca_chain[1]' output.json > ca-chain1.crt
    jq -r '.data .certificate' output.json > certificate.crt
    jq -r '.data .private_key' output.json > private.key
    
    openssl pkcs12 -export -in certificate.crt -inkey private.key -name "$CERT_PREFIX-client" -out bundle.p12 -password "pass:$KEYSTORE_PASSWORD"

    docker run -v $(pwd):/root -w /root -it openjdk:11 keytool -importkeystore -deststorepass "$KEYSTORE_PASSWORD" -destkeystore "$(basename $KEYSTORE_FILE)" -srckeystore bundle.p12 -srcstoretype PKCS12 -srcstorepass "$KEYSTORE_PASSWORD"
    docker run -v $(pwd):/root -w /root -it openjdk:11 keytool -import -alias "$CERT_PREFIX-kafka_ca_1" -file ca-chain1.crt -keystore "$(basename $KEYSTORE_FILE)" -storepass "$KEYSTORE_PASSWORD" -noprompt
    docker run -v $(pwd):/root -w /root -it openjdk:11 keytool -import -alias "$CERT_PREFIX-kafka_ca_2" -file ca-chain0.crt -keystore "$(basename $KEYSTORE_FILE)" -storepass "$KEYSTORE_PASSWORD" -noprompt

    echo "Moving keystore to current directory from tmp"
    cp "$WORK_DIR/$(basename $KEYSTORE_FILE)" $KEYSTORE_DESTINATION
    echo "Cleaning up"
    rm bundle.p12 output.json ca-chain0.crt ca-chain1.crt certificate.crt private.key
    echo "Done creating keystore file"

    echo "Writing secret to vault at path $SECRET_PATH"
    pscli vault write $SECRET_PATH keystore_password=$KEYSTORE_PASSWORD keystore=$(base64 $KEYSTORE_DESTINATION)
    echo "Done writing to vault"
) }
