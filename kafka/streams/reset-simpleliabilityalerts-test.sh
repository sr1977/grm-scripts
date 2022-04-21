kafka-streams-application-reset \
    --bootstrap-servers=gueaplatkafkatradingtst02.skybet.net:9093 \
    --application-id=simpleliabilityalerts-test \
    --input-topics=gstp.risk.liabilities.bets.total.liabilities.test \
    --to-latest \
    --config-file /Users/sri01/workspace/grm-scripts/kafka/keystores/simpleliabilityalerts-test.properties
