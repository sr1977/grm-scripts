 ~/workspace/confluent-5.5.1/bin/kafka-avro-console-consumer \
    --bootstrap-server=gueaplatkafkareptst01.skybet.net:9093 \
    --topic=bet.repstack.test4.staging.enriched \
    --group=gstp.risk.edsresulting.stage.debug \
    --property print.key=true \
    --property schema.registry.url=https://schema-registry.test.platformservices.io \
    --value-deserializer io.confluent.kafka.serializers.KafkaAvroDeserializer \
    --key-deserializer org.apache.kafka.common.serialization.StringDeserializer \
    --consumer.config /Users/sri01/workspace/grm-scripts/kafka/keystores/edsresulting-test.properties 
