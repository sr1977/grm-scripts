kafka-streams-application-reset \
    --bootstrap-servers=localhost:9092 \
    --application-id=analytics-local \
    --input-topics=gstp.risk.alerting.alerts.local \
    --to-latest \
