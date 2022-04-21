kafka-streams-application-reset \
    --bootstrap-servers=gueaplatkafkatradingtst02.skybet.net:9093 \
    --application-id=popularrabs \
    --input-topics=hackathon.rabs.test,bet.trading.orwell.bets,hackathon.popularrabs.test \
    --to-latest \
    --config-file /Users/sri01/workspace/grm-scripts/kafka/keystores/hackathon-popularrabs-test.properties

rm -fr /tmp/kafka-streams
