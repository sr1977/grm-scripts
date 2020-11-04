 ~/workspace/confluent-5.5.1/bin/kafka-avro-console-consumer \
    --bootstrap-server=gueaplatkafkatradingtst02.skybet.net:9093 \
    --topic=risk.alerting.action.test \
    --group=opsalerts-test-debug2 \
    --property print.key=true \
    --value-deserializer io.confluent.kafka.serializers.KafkaAvroDeserializer \
    --key-deserializer org.apache.kafka.common.serialization.StringDeserializer \
    --property schema.registry.url=https://schema-registry.test.platformservices.io \
    --consumer.config /Users/sri01/workspace/grm-scripts/kafka/keystores/opsalerts-test.properties
