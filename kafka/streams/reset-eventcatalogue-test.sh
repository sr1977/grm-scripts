kafka-streams-application-reset \
    --bootstrap-servers=gueaplatkafkatradingtst02.skybet.net:9093 \
    --application-id=eventcatalogue-test \
    --input-topics=bet.trading.orwell.bets \
    --config-file /Users/sri01/workspace/grm-scripts/kafka/keystores/eventcatalogue-test.properties \
    --to-earliest
kafka-streams-application-reset \
    --bootstrap-servers=gueaplatkafkatradingtst02.skybet.net:9093 \
    --application-id=eventcatalogue-test \
    --input-topics=gstp.risk.liabilities.selections.outcomes.test \
    --config-file /Users/sri01/workspace/grm-scripts/kafka/keystores/eventcatalogue-test.properties \
    --to-latest
