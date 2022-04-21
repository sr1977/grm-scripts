kafka-consumer-groups --command-config /Users/sri01/workspace/grm-scripts/kafka/keystores/liabilities-stage.properties --bootstrap-server gueaplatkafkatradingtst01:9093  --reset-offsets --group gstp.risk.liabilities.aggregator.stage  --topic bet.trading.orwell.staging.bets --shift-by 1 --dry-run


