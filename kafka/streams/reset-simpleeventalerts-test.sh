kafka-streams-application-reset \
    --bootstrap-servers=gueaplatkafkatradingtst02.skybet.net:9093 \
    --application-id=eventalerts-test \
    --input-topics=trading.risk.event.test \
    --to-latest \
    --config-file /Users/sri01/workspace/grm-scripts/kafka/keystores/simpleeventalerts-test.properties
