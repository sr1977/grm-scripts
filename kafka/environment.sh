source ${GRM_SCRIPTS:?}/environment.sh

function kafka_scripts_home() {
    echo ${GRM_SCRIPTS}/kafka
}

function keystore_directory() {
    local keystore_dir=$(kafka_scripts_home)/keystores
    mkdir -p $keystore_dir 2&> /dev/null
    echo $keystore_dir
}

