kafka-streams-application-reset \
    --bootstrap-servers=gueaplatkafkatradingtst02.skybet.net:9093 \
    --application-id=gstp.risk.liabilities.resulting.test \
    --input-topics=gstp.risk.liabilities.bets.individual.test,gstp.risk.liabilities.selections.outcomes.test,gstp.risk.liabilities.resulting.compositeidlookup.test,gstp.risk.liabilities.resulting.resultedids.test \
    --to-latest \
    --config-file /Users/sri01/workspace/grm-scripts/kafka/keystores/liabilitiesresulting-test.properties
