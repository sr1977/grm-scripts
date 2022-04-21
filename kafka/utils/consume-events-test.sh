 ~/workspace/confluent-5.5.1/bin/kafka-avro-console-consumer \
    --bootstrap-server=gueaplatkafkatradingtst02.skybet.net:9093 \
    --group eventupdate-test-steve \
    --property schema.registry.url=https://schema-registry.test.platformservices.io/ \
    --topic=sstrading.risk.event.test \
    --consumer.config /Users/sri01/workspace/grm-scripts/kafka/keystores/kafkaconnecteventupdate-test.properties
