function reset_query_service() {
	kafka-streams-application-reset \
		--bootstrap-servers=localhost:9092 \
		--application-id=liabilityqueryservice-local \
		--input-topics=liabilities-generic-aggregates \
		--to-latest 
}

function reset_aggregate_service() {
	kafka-streams-application-reset \
		--bootstrap-servers=localhost:9092 \
		--application-id=liabilities-local \
		--input-topics=orwell-bet-in \
		--to-latest 
}

function clear_state_stores() {
    rm -rf /tmp/kafka-streams
}

function rocksdb_contents() {
    local store=${1:?Enter store name}
    local db_dir=$(find /tmp/kafka-streams -type d | grep "rocksdb/$store" | head -1)
    if [[ -z "$db_dir" ]]; then
        echo "Can't find rocksdb"
        exit 1
    fi

    echo "Using rocksdb at $db_dir"
    $(pwd)/ldb --db=$db_dir scan    
}


function purge_all_streams() {
    reset_aggregate_service
    reset_query_service
    clear_state_stores
}
