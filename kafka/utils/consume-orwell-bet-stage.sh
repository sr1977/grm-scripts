kafka-console-consumer \
    --bootstrap-server=gueaplatkafkatradingtst02.skybet.net:9093 \
    --group=bet.aggregator.stage.tradingmodels.io \
    --topic=bet.trading.orwell.staging.bets \
    --consumer.config /Users/sri01/workspace/grm-scripts/kafka/keystores/modelsbetaggregator-stage.properties
