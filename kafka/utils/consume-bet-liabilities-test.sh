/Users/sri01/workspace/confluent-5.5.1/bin/kafka-avro-console-consumer \
    --consumer.config ~/workspace/grm-scripts/kafka/keystores/liabilityqueryservice-test.properties \
    --bootstrap-server=gueaplatkafkatradingtst02.skybet.net:9093 \
    --property schema.registry.url="https://schema-registry.test.platformservices.io/" \
    --group=gstp.risk.liabilities.queryservice.test.testing2 \
    --topic=gstp.risk.liabilities.bets.total.liabilities.test
