kafka-streams-application-reset \
    --bootstrap-servers=gueaplatkafkatradingtst02.skybet.net:9093 \
    --application-id=gstp.risk.liabilities.aggregator.test \
    --input-topics=gstp.risk.liabilities.bets.individual.test,bet.trading.orwell.bets,bet.trading.orwell.canonical.test \
    --to-latest \
    --config-file /Users/sri01/workspace/grm-scripts/kafka/keystores/liabilities-test.properties
