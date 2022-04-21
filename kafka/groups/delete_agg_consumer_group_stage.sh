kafka-consumer-groups \
    --command-config /Users/sri01/workspace/grm-scripts/kafka/keystores/liabilities-stage.properties \
    --bootstrap-server gueaplatkafkatradingtst01.skybet.net:9093 \
    --delete-offsets \
    --group gstp.risk.liabilities.aggregator.stage \
    --topic bet.trading.orwell.bets
