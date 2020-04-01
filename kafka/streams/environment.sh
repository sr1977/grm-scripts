source ${GRM_SCRIPTS:?}/kafka/environment.sh

function kafka_streams_home_directory() {
    echo ${GRM_SCRIPTS}/kafka/streams
}

function kafka_streams_reset_query_service() {
    kafka-streams-application-reset \
        --bootstrap-servers=localhost:9092 \
        --application-id=liabilityqueryservice-local \
        --input-topics=liabilities-generic-aggregates \
        --to-latest 
}

function kafka_streams_reset_resulting_service() {
    kafka-streams-application-reset \
        --bootstrap-servers=localhost:9092 \
        --application-id=liabilities-resulting \
        --input-topics=liabilities-bet-individual \
        --to-earliest 
}

function kafka_streams_reset_aggregate_service() {
    kafka-streams-application-reset \
        --bootstrap-servers=localhost:9092 \
        --application-id=liabilities-local \
        --input-topics=orwell-bet-in \
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
