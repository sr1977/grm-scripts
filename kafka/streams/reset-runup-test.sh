kafka-streams-application-reset \
    --bootstrap-servers=gueaplatkafkatradingtst02.skybet.net:9093 \
    --application-id=glm-runup-test \
    --input-topics=gstp.risk.liabilities.bets.individual.test,bet.trading.glm.composites.resulted.test \
    --to-latest \
    --config-file /Users/sri01/workspace/grm-scripts/kafka/keystores/glm-runup-test.properties
