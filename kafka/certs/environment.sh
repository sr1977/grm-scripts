#!/bin/bash

source ${GRM_SCRIPTS:?}/kafka/environment.sh

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

function kafka_cert_cluster() {
    echo "${KAFKA_CERT_CLUSTER:-trading}"
}

function kafka_cert_squad() {
    echo "${KAFKA_CERT_SQUAD:-gstp-risk-management}"
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
    local usage="Usage: create_cert app_name environment keystore_password"
    local app=${1:?$usage}
    local environment=${2:?$usage}
    local keystore_password=${3:?$usage}

    local cluster=$(kafka_cert_cluster)
    local cluster_env=$(kafka_cert_broker_env $environment)
    local squad=$(kafka_cert_squad)
    local vault_path="ps-pki/kafka/${cluster}/${cluster_env}/issue/${squad}"
    local keystore_name=$(basename $(kafka_cert_keystore_path $app $environment)) 

    local tmp_dir=$(keystore_directory)/tmp
    local cert=$tmp_dir/output.json
    mkdir $tmp_dir &> /dev/null

    pscli vault -- write -format=json "$vault_path" common_name="$app" ttl=131490h > $cert

    jq -r '.data .ca_chain[0]' $cert > $tmp_dir/ca-chain0.crt
    jq -r '.data .ca_chain[1]' $cert > $tmp_dir/ca-chain1.crt
    jq -r '.data .certificate' $cert > $tmp_dir/certificate.crt
    jq -r '.data .private_key' $cert > $tmp_dir/private.key
    
    openssl pkcs12 -export -in $tmp_dir/certificate.crt -inkey $tmp_dir/private.key -name "$(kafka_cert_cluster)-client" -out $tmp_dir/bundle.p12 -password "pass:${keystore_password}"

    docker run -v $(keystore_directory):/root -w /root -it openjdk:11 keytool -importkeystore -deststorepass "$keystore_password" -destkeystore "$keystore_name" -srckeystore tmp/bundle.p12 -srcstoretype PKCS12 -srcstorepass "$keystore_password"
    docker run -v $(keystore_directory):/root -w /root -it openjdk:11 keytool -import -alias "$(kafka_cert_cluster)-kafka_ca_1" -file tmp/ca-chain1.crt -keystore "$keystore_name" -storepass "$keystore_password" -noprompt
    docker run -v $(keystore_directory):/root -w /root -it openjdk:11 keytool -import -alias "$(kafka_cert_cluster)-kafka_ca_2" -file tmp/ca-chain0.crt -keystore "$keystore_name" -storepass "$keystore_password" -noprompt

   rm -r $tmp_dir
}

function kafka_cert_create_password() {
    if ! [ -x "$(command -v pwgen)" ]; then
        echo 'pwgen missing - try "brew install pwgen"'
        exit 1
    fi
    pwgen 16 1
}

function kafka_cert_generate() {
    local usage="app environment"
    local app=${1:?$usage}
    local environment=${2:?$usage}
    local password=$(kafka_cert_create_password)

    kafka_cert_archive_keystore $app $environment
    kafka_cert_create_keystore $app $environment $password
    kafka_cert_publish_secret $app $environment $password
}

