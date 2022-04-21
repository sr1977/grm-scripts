kafka-streams-application-reset \
    --bootstrap-servers=gueaplatkafkatradingtst02.skybet.net:9093 \
    --application-id=glm-runup-stage \
    --input-topics=gstp.risk.liabilities.bets.individual.stage,bet.trading.glm.composites.resulted.stage \
    --to-latest \
    --config-file /Users/sri01/workspace/grm-scripts/kafka/keystores/glm-runup-stage.properties
