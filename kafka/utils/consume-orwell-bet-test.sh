kafka-console-consumer \
    --bootstrap-server=gueaplatkafkatradingtst02.skybet.net:9093 \
    --group=gstp.risk.liabilities.aggregator.test.testing \
    --topic=bet.trading.orwell.bets \
    --consumer.config /Users/sri01/workspace/grm-scripts/kafka/keystores/liabilities-test.properties
