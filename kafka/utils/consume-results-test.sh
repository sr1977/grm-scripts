kafka-console-consumer \
    --bootstrap-server=gueaplatkafkatradingtst02.skybet.net:9093 \
    --group=gstp.risk.liabilities.resulting.test.testing \
    --topic=gstp.risk.liabilities.selections.outcomes.test \
    --consumer.config /Users/sri01/workspace/grm-scripts/kafka/keystores/liabilitiesresulting-test.properties
