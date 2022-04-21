 ~/workspace/confluent-5.5.1/bin/kafka-topics \
    --command-config /Users/sri01/workspace/grm-scripts/kafka/keystores/selectionaggregator-stage.properties \
    --bootstrap-server gueaplatkafkatradingtst01:9093 \
    --describe \
    --topic selectionaggregator-stage-selections-repartition
