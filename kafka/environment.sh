source ${GRM_SCRIPTS:?}/environment.sh

function kafka_scripts_home() {
    echo ${GRM_SCRIPTS}/kafka
}

function keystore_directory() {
    local keystore_dir=$(kafka_scripts_home)/keystores
    mkdir -p $keystore_dir &> /dev/null
    echo $keystore_dir
}

function bootstrap_server() {
    OPTIND=1

    local options=":st"

    while getopts $options opt; do
        case $opt in
            s)
                local server="gueaplatkafkatradingtst01.skybet.net:9093"
                ;;
            t)
                local server="gueaplatkafkatradingtst01.skybet.net:9093"
                ;;
            \?)
                local server="localhost:9092"
                ;;
        esac
    done

    shift $((OPTIND - 1))

    echo "$server"
}
