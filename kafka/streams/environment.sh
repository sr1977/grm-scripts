source ${GRM_SCRIPTS:?}/kafka/environment.sh

function kafka_streams_reset_query_service() {
    kafka-streams-application-reset \
        --bootstrap-servers=localhost:9092 \
        --application-id=liabilityqueryservice-local \
        --input-topics=liabilities-generic-aggregates \
        --to-latest 
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
    $(pwd)/ldb --db=$db_dir scan    
}


function kafka_streams_purge() {
    kafka_streams_reset_aggregate_service
    kafka_streams_reset_query_service
    kafka_streams_clear_state_stores
}
