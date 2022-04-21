#!/bin/bash

source ${GRM_SCRIPTS:?}/kafka/environment.sh

function kafka_cert_fetch_credentials() {
    local usage="appname environment"
    local app=${1:?$usage}
    local environment=${2:?$usage}
    
    local path=$(kafka_cert_vault_path $app $environment)
    local keystore=$(kafka_cert_keystore_path $app $environment)
    local props_file=$(keystore_directory)/${app}-${environment}.properties

    pscli vault -- read --field keystore $path | base64 -D > $keystore
    local password=$(pscli vault -- read --field keystore_password $path)
    
    cat <<EOF > $props_file
security.protocol=SSL
ssl.truststore.location=$keystore
ssl.truststore.password=$password
ssl.keystore.location=$keystore
ssl.keystore.password=$password
ssl.key.password=$password
ssl.endpoint.identification.algorithm=
EOF
    echo "Created props file at $props_file"
}

function kafka_cert_keystore_path() {
    local usage="appname environment"
    local app=${1:?$usage}
    local env=${2:?$usage}
    echo "$(keystore_directory)/${app}-${env}-keystore.jks"
}

function kafka_cert_archive_keystore() {
    local usage="appname environment"
    local app=${1:?$usage}
    local env=${2:?$usage}
    local keystore="$(kafka_cert_keystore_path $app $env)"

    if [ -f "$keystore" ]; then
        echo "Archiving previous keystore"
        mv -v $keystore ${keystore}.prev
    fi
}
       
function kafka_cert_vault_path() {
    local usage="app_name environment"
    local app=${1:?$usage}
    local environment=${2:?$usage}
    echo "secret/trading/gbm/${environment}/${app}/kafka"
}

function kafka_cert_publish_secret() {
    local usage="app_name environment keystore_password"
    local app=${1:?$usage}
    local environment=${2:?$usage}
    local keystore_password=${3:?$usage}

    local path=$(kafka_cert_vault_path $app $environment)
    local keystore=$(kafka_cert_keystore_path $app $environment)
    local encoded_keystore=$(base64 $keystore)

    echo "Writing secret to vault at path $path"
    pscli vault write $path keystore_password=$keystore_password keystore=$encoded_keystore
}

function kafka_cert_squad() {
    echo "${KAFKA_CERT_SQUAD:-gstp-risk-management}"
}

function kafka_cert_scratch_directory() {
    echo $(keystore_directory)/scratch
}

function kafka_cert_delete_scratch_directory() {
    if [ -e "$(kafka_cert_scratch_directory)" ]; then
        rm -rf $(kafka_cert_scratch_directory)
    fi
}

function kafka_cert_broker_env() {
    local env=${1:?No env supplied}
    
    case "$env" in
        "live" | "nps")
            local broker_env="prod"
            ;;
        *)
            local broker_env="test"
            ;;
    esac
    echo $broker_env
}

# Following plat-services guide https://tools.skybet.net/confluence/display/PSK/Requesting+a+certificate+-+the+automated+method
function kafka_cert_create_keystore() {
    local usage="Usage: create_cert app_name environment keystore_password cluster common_name"
    local app=${1:?$usage}
    local environment=${2:?$usage}
    local keystore_password=${3:?$usage}
    local cluster=${4:?$usage}
    local cn=${5:-$app}

    local cluster_env=$(kafka_cert_broker_env $environment)
    local squad=$(kafka_cert_squad)
    local vault_path="ps-pki/kafka/${cluster}/${cluster_env}/issue/${squad}"
    local keystore_name=$(basename $(kafka_cert_keystore_path $app $environment)) 

    local tmp_dir=$(kafka_cert_scratch_directory)
    local cert=$tmp_dir/output.json
    mkdir $tmp_dir &> /dev/null

    echo "Using CN $cn"
    pscli vault -- write -format=json "$vault_path" common_name="$cn" ttl=131490h > $cert

    local ca_chain_0=$tmp_dir/ca-${cluster}-chain0.crt
    local ca_chain_1=$tmp_dir/ca-${cluster}-chain1.crt
    local certificate=$tmp_dir/certificate-${cluster}.crt
    local key=$tmp_dir/${cluster}.key
    local bundle=$tmp_dir/bundle-${cluster}.p12

    jq -r '.data .ca_chain[0]' $cert > $ca_chain_0
    jq -r '.data .ca_chain[1]' $cert > $ca_chain_1
    jq -r '.data .certificate' $cert > $certificate
    jq -r '.data .private_key' $cert > $key
    
    openssl pkcs12 -export -in $certificate -inkey $key -name "${cluster}-client" -out "$bundle" -password "pass:${keystore_password}"

    docker run -v $(keystore_directory):/root -v $tmp_dir:/scratch -w /root -it adoptopenjdk/openjdk11:jre-11.0.8_10 keytool -importkeystore -deststorepass "$keystore_password" -destkeystore "$keystore_name" -srckeystore "/scratch/$(basename $bundle)" -srcstoretype PKCS12 -srcstorepass "$keystore_password"
    docker run -v $(keystore_directory):/root -v $tmp_dir:/scratch -w /root -it adoptopenjdk/openjdk11:jre-11.0.8_10 keytool -import -alias "${cluster}-kafka_ca_1" -file "/scratch/$(basename $ca_chain_1)" -keystore "$keystore_name" -storepass "$keystore_password" -noprompt
    docker run -v $(keystore_directory):/root -v $tmp_dir:/scratch -w /root -it adoptopenjdk/openjdk11:jre-11.0.8_10 keytool -import -alias "${cluster}-kafka_ca_2" -file "/scratch/$(basename $ca_chain_0)" -keystore "$keystore_name" -storepass "$keystore_password" -noprompt

}

function kafka_cert_create_password() {
    if ! [ -x "$(command -v pwgen)" ]; then
        echo 'pwgen missing - try "brew install pwgen"'
        exit 1
    fi
    pwgen 16 1
}

function kafka_cert_generate() {
    local usage="app environment [CN (if different from app name)]"
    local app=${1:?$usage}
    local environment=${2:?$usage}
    local cn=${3:-$app}
    kafka_cert_generate_multi_cluster -a $app -e $environment -n $cn -c trading
}

function kafka_cert_generate_multi_cluster() {
    OPTIND=1

    local usage="-a <app_name> -e <environment> -n <CN (default: app name)> -c <cluster1> -c <cluster2> ... -c <clusterN>"
    local options=":a:c:e:n:"

    while getopts $options opt; do
        case $opt in
            a)
                local app_name=$OPTARG
                ;;
            c)
                clusters+=("$OPTARG")
                ;;
            e)
                local environment=$OPTARG
                ;;
            n)
                local common_name=$OPTARG
                ;;
            \?)
                stderr $usage
                return 2
                ;;
        esac
    done

    shift $((OPTIND - 1))

    local password=$(kafka_cert_create_password)

    kafka_cert_archive_keystore ${app_name:?$usage} ${environment:?$usage}
    for cluster in "${clusters[@]}"; do
        echo "Generating cert against $cluster cluster"       
        kafka_cert_create_keystore ${app_name:?$usage} ${environment:?$usage} $password $cluster ${cn:-$app_name}
    done

    kafka_cert_publish_secret ${app_name:?$usage} ${environment:?$usage} $password
   # kafka_cert_delete_scratch_directory
}



