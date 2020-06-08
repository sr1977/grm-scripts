kafka-streams-application-reset \
    --bootstrap-servers=gueaplatkafkatradingtst02.skybet.net:9093 \
    --application-id=eventcatalogue-stage \
    --input-topics=bet.trading.orwell.staging.bets \
    --config-file /Users/sri01/workspace/grm-scripts/kafka/keystores/eventcatalogue-stage.properties \
    --to-latest
kafka-streams-application-reset \
    --bootstrap-servers=gueaplatkafkatradingtst02.skybet.net:9093 \
    --application-id=eventcatalogue-stage \
    --input-topics=gstp.risk.liabilities.selections.outcomes.stage \
    --config-file /Users/sri01/workspace/grm-scripts/kafka/keystores/eventcatalogue-stage.properties \
    --to-latest
