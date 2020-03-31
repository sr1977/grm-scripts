#!/bin/bash

source ${GRM_SCRIPTS:?}/kafka/environment.sh

function kafka_utils_topics() {
    kafka-topics --bootstrap-server localhost:9092 $@
}

function kafka_utils_consume() {
    kafka-console-consumer --bootstrap-server localhost:9092 $@
}

function kafka_utils_produce() {
    kafka-console-producer --broker-list localhost:9092 \
        --property "parse.key=true" \
        --property "key.separator=," \
        $@
}

function kafka_utils_list_topics() {
    kafka_utils_topics --list
}

function kafka_utils_describe_topic() {
    kafka_utils_topics --describe --topic ${1:?No topic name supplied} $@
}

function kafka_utils_create_topic() {
    local name=${1:?Usage: create_topic name [partitions (default: 1)] [replication (default: 1)]}
    local partitions=${2:-1}
    local replication=${3:-1}
    kafka_utils_topics --create --topic $name --partitions $partitions --replication-factor $replication $@
}

function kafka_utils_delete_topic() {
    kafka_utils_topics --delete --topic ${1:?No topic name supplied} $@
}

function kafka_utils_produce_message() {
    kafka_utils_produce --topic ${1:?No topic name supplied} $@
}

function kafka_utils_consume_topic() {
    local name=${1:?Usage: consume_topic name [offset (default: latest)] }
    kafka_utils_consume --topic $name $@
}
