 ~/workspace/confluent-5.5.1/bin/kafka-avro-console-consumer \
    --bootstrap-server=gueaplatkafkatradingtst02.skybet.net:9093 \
    --group glm-kafkaconnect-test-steve \
    --property schema.registry.url=https://schema-registry.test.platformservices.io/ \
    --topic=bet.trading.glm.runup.total.test \
    --consumer.config /Users/sri01/workspace/grm-scripts/kafka/keystores/glm-kafkaconnect-test.properties
