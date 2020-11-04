 ~/workspace/confluent-5.5.1/bin/kafka-avro-console-consumer \
    --bootstrap-server=localhost:9092 \
    --group newalerts-consumer-test-steve \
    --topic=gstp.risk.alerting.alerts.local \
    --property schema.registry.url=http://localhost:8081
