kafka-streams-application-reset \
    --bootstrap-servers=gueaplatkafkatradingtst02.skybet.net:9093 \
    --application-id=gstp.risk.liabilities.resulting.stage \
    --input-topics=gstp.risk.liabilities.bets.individual.stage,gstp.risk.liabilities.selections.outcomes.stage \
    --to-latest \
    --config-file /Users/sri01/workspace/grm-scripts/kafka/keystores/liabilitiesresulting-stage.properties
