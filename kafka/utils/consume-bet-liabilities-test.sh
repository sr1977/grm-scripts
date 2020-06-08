kafka-console-consumer \
    --bootstrap-server=gueaplatkafkatradingtst02.skybet.net:9093 \
    --group=gstp.risk.liabilities.queryservice.test.testing \
    --topic=gstp.risk.liabilities.bets.total.liabilities.test \
    --consumer.config /Users/sri01/workspace/grm-scripts/kafka/keystores/liabilityqueryservice-test.properties
