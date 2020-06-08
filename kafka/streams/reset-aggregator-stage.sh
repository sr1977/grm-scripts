kafka-streams-application-reset \
    --bootstrap-servers=gueaplatkafkatradingtst02.skybet.net:9093 \
    --application-id=gstp.risk.liabilities.aggregator.stage \
    --input-topics=gstp.risk.liabilities.bets.individual.stage,bet.trading.orwell.bets \
    --to-latest \
    --config-file /Users/sri01/workspace/grm-scripts/kafka/keystores/liabilities-stage.properties
