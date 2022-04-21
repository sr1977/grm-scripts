kafka-console-consumer \
    --bootstrap-server=gueaplatkafkatradingtst02.skybet.net:9093 \
    --topic=openbet.events.raw \
    --offset=earliest \
    --partition=6 \
    --property print.offset=true \
    --property print.key=true \
    --consumer.config /Users/sri01/workspace/grm-scripts/kafka/keystores/openbetadaptor-stage.properties
