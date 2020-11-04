kafka-streams-application-reset \
    --bootstrap-servers=gueaplatkafkatradingtst02.skybet.net:9093 \
    --application-id=alertruleenricher-test \
    --input-topics=gstp.risk.alerting.config.test \
    --to-latest \
    --config-file /Users/sri01/workspace/grm-scripts/kafka/keystores/alertruleenricher-test.properties
