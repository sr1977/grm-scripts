kafka-consumer-groups \
    --command-config /Users/sri01/workspace/grm-scripts/kafka/keystores/alerting-kafkaconnect-test.properties \
    --bootstrap-server gueaplatkafkatradingtst01:9093 \
    --reset-offsets  \
    --to-latest \
    --execute \
    --topic gstp.risk.alerting.operation.test \
    --group gam-kafkaconnect-test


