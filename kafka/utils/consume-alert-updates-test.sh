 ~/workspace/confluent-5.5.1/bin/kafka-avro-console-consumer \
    --bootstrap-server=gueaplatkafkatradingtst02.skybet.net:9093 \
    --property schema.registry.url=https://schema-registry.test.platformservices.io/ \
    --group alertservice-test-steve \
    --topic=gstp.risk.alerting.alerts.updates.test \
    --consumer.config /Users/sri01/workspace/grm-scripts/kafka/keystores/alertservice-test.properties
