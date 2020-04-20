source ${GRM_SCRIPTS:?}/kafka/environment.sh

function kafka_streams_home_directory() {
    echo ${GRM_SCRIPTS}/kafka/streams
}

function kafka_streams_reset_query_service() {
    kafka-streams-application-reset \
        --bootstrap-servers=localhost:9092 \
        --application-id=liabilityqueryservice-local \
        --input-topics=liabilities-generic-aggregates,liabilities-windowed-aggregates \
        --to-latest 
}

function kafka_streams_reset_resulting_service() {
    kafka-streams-application-reset \
        --bootstrap-servers=localhost:9092 \
        --application-id=liabilitiesresulting \
        --input-topics=liabilities-bet-individual \
        --to-latest
}

function kafka_streams_reset_aggregate_service() {
    kafka-streams-application-reset \
        --bootstrap-servers=localhost:9092 \
        --application-id=liabilities-local \
        --input-topics=orwell-bet-in,liabilities-generic-aggregates,liabilities-bet-individual \
        --to-latest 
}

function kafka_streams_reset_stream() {
    local env=local
    local bootstrap_server=$(bootstrap_server -l)

    OPTIND=1

    local options=":st"

    while getopts $options opt; do
        case $opt in
            s)
                local env=stage
                local bootstrap_server=$(bootstrap_server -s)
                ;;
            t)
                local env=test
                local bootstrap_server=$(bootstrap_server -t)
                ;;
            \?)
                echo "Unknown environment, defaulting to local"
                ;;
        esac
    done

    shift $((OPTIND - 1))

    local application=${1:?Please specify app to reset}
    # TODO Have some kind of app -> topic config
    local input_topics=${2:?List of topics (comma separated) to reset}
    # TODO - check if the file exists, and if not drag it in from vault
    local command_config="$(keystore_directory)/${application}-${env}.properties"

    echo "Resetting $application in ${env:?No env specified}"
    kafka-streams-application-reset \
        --bootstrap-servers=$bootstrap_server \
        --application-id=${application}-$env \
        --config-file="$command_config" \
        --input-topics="$input_topics" \
        --to-latest 

}

function kafka_streams_clear_state_stores() {
    rm -rf /tmp/kafka-streams
}

function kafka_streams_rocksdb_scan() {
    local store=${1:?Enter store name}
    local db_dir=$(find /tmp/kafka-streams -type d | grep "rocksdb/$store" | head -1)
    if [[ -z "$db_dir" ]]; then
        echo "Can't find rocksdb"
        exit 1
    fi

    echo "Using rocksdb at $db_dir"
    $(kafka_streams_home_directory)/ldb --db=$db_dir scan    
}


function kafka_streams_purge() {
    echo "Resetting aggregate service"
    kafka_streams_reset_aggregate_service
    echo "Resetting query service"
    kafka_streams_reset_query_service
    echo "Resetting resulting service"
    kafka_streams_reset_resulting_service
    kafka_streams_clear_state_stores
}
