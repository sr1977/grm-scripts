kafka-streams-application-reset \
    --bootstrap-servers=gueaplatkafkatradingtst02.skybet.net:9093 \
    --application-id=glm-metadata-stage \
    --input-topics=bet.trading.orwell.staging.bets \
    --to-latest \
    --config-file /Users/sri01/workspace/grm-scripts/kafka/keystores/glm-metadata-stage.properties
