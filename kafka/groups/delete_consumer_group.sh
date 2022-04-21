kafka-consumer-groups \
    --command-config /Users/sri01/workspace/grm-scripts/kafka/keystores/glm-metadata-test.properties \
    --bootstrap-server gueaplatkafkatradingtst01.skybet.net:9093 \
    --delete-offsets \
    --group glm-metadata-test \
    --topic bet.trading.glm.runup.total.stage
