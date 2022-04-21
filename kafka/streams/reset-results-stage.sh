kafka-streams-application-reset \
    --bootstrap-servers=gueaplatkafkatradingtst02.skybet.net:9093 \
    --application-id=glm-results-stage \
    --input-topics=gstp.risk.liabilities.bets.individual.stage \
    --to-latest \
    --config-file /Users/sri01/workspace/grm-scripts/kafka/keystores/glm-results-stage.properties
