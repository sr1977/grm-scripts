kafka-streams-application-reset \
    --bootstrap-servers=gueaplatkafkatradingtst02.skybet.net:9093 \
    --application-id=gstp.risk.liabilities.queryservice.stage \
    --input-topics=gstp.risk.liabilities.global.top.liablities.stage,gstp.risk.liabilities.bets.total.liabilities.stage,gstp.risk.liabilities.bets.total.liabilities.windowed.stage \
    --to-latest \
    --config-file /Users/sri01/workspace/grm-scripts/kafka/keystores/liabilityqueryservice-stage.properties
