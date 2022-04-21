kafka-streams-application-reset \
    --bootstrap-servers=gueaplatkafkatradingtst02.skybet.net:9093 \
    --application-id=simplealerts-stage \
    --input-topics=gstp.risk.alerting.config.stage,bet.trading.orwell.staging.bets \
    --to-latest \
    --config-file /Users/sri01/workspace/grm-scripts/kafka/keystores/simplealerts-stage.properties
