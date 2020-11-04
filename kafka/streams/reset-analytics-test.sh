kafka-streams-application-reset \
    --bootstrap-servers=gueaplatkafkatradingtst02.skybet.net:9093 \
    --application-id=analytics-test \
    --input-topics=gstp.risk.alerting.alerts.test \
    --to-latest \
    --config-file /Users/sri01/workspace/grm-scripts/kafka/keystores/analytics-test.properties
