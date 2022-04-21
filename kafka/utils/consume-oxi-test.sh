 ~/workspace/confluent-5.5.1/bin/kafka-console-consumer \
    --bootstrap-server=gueaplatkafkareptst01.skybet.net:9093 \
    --group com.skybet.risk.oxiadaptor.test.tmp \
    --topic=bet.repstack.test4.rep.raw \
    --property print.key=true \
    --consumer.config /Users/sri01/workspace/grm-scripts/kafka/keystores/oxiadaptor-test.properties
