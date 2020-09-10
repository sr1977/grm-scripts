kafka-streams-application-reset \
    --bootstrap-servers=gueaplatkafkatradingtst02.skybet.net:9093 \
    --application-id=simplealerts-test \
    --input-topics=gstp.risk.alerting.config.test,,bet.trading.orwell.bets \
    --to-latest \
    --config-file /Users/sri01/workspace/grm-scripts/kafka/keystores/simplealerts-test.properties
