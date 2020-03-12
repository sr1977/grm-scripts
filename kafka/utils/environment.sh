function kafka_topics() {
    kafka-topics --bootstrap-server localhost:9092 $@
}

function kafka_consume() {
    kafka-console-consumer --bootstrap-server localhost:9092 $@
}

function kafka_produce() {
    kafka-console-producer --broker-list localhost:9092 \
        --property "parse.key=true" \
        --property "key.separator=," \
        $@
}

function list_topics() {
    kafka_topics --list
}

function create_topic() {
    local name=${1:?Usage: create_topic name [partitions (default: 1)] [replication (default: 1)]}
    local partitions=${2:-1}
    local replication=${3:-1}
    kafka_topics --create --topic $name --partitions $partitions --replication-factor $replication $@
}

function delete_topic() {
    kafka_topics --delete --topic ${1:?No topic name supplied} $@
}

function produce_message() {
    kafka_produce --topic ${1:?No topic name supplied} $@
}

function consume_topic() {
    local name=${1:?Usage: consume_topic name [offset (default: latest)] }
    kafka_consume --topic $name $@
}
