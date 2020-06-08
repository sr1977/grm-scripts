kafka-streams-application-reset \
    --bootstrap-servers=gueaplatkafkatradingtst02.skybet.net:9093 \
    --application-id=gstp.risk.liabilities.queryservice.test \
    --input-topics=gstp.risk.liabilities.global.top.liablities.test,gstp.risk.liabilities.bets.total.liabilities.test,gstp.risk.liabilities.bets.total.liabilities.windowed.test \
    --to-latest \
    --config-file /Users/sri01/workspace/grm-scripts/kafka/keystores/liabilityqueryservice-test.properties
