kafka-streams-application-reset \
    --bootstrap-servers=localhost:9092 \
    --application-id=alertruleenricher-local \
    --input-topics=gstp.risk.alerting.watchlist.local,gstp.risk.alerting.config.local \
    --to-latest 
