kafka-topics \
    --command-config /Users/sri01/workspace/grm-scripts/kafka/keystores/selectionaggregator-test.properties \
    --bootstrap-server gueaplatkafkatradingtst01:9093 \
    --describe \
    --topic selectionaggregator-test-selections-repartition
