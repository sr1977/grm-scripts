date=${1:?No date given, should be in form 'YYYY-MM-DDTHH:mm'}
kafka-consumer-groups --command-config /Users/sri01/workspace/grm-scripts/kafka/keystores/glm-results-test.properties --bootstrap-server gueaplatkafkatradingtst01:9093  --reset-offsets --to-datetime "${date}:00.000" --group glm-results-test  --topic gstp.risk.liabilities.bets.individual.test --execute
