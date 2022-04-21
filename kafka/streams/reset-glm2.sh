kafka-streams-application-reset \
    --bootstrap-servers=localhost:9092 \
    --application-id=glm-metadata-local \
    --input-topics=orwell-bet-in,bet.trading.orwell.canonical.local,gstp.risk.liabilities.bets.individual.local,resulted-composites,composite-lookup,runup-money,partially-resulted,selection_data \
    --to-latest 

kafka-streams-application-reset \
    --bootstrap-servers=localhost:9092 \
    --application-id=glm-runup-local \
    --input-topics=bet.trading.glm.composites.resulted.local,gstp.risk.liabilities.bets.individual.local \
    --to-latest 

kafka-streams-application-reset \
    --bootstrap-servers=localhost:9092 \
    --application-id=glm-results-local \
    --input-topics=gstp.risk.liabilities.selections.outcomes.local \
    --to-latest 

rm -rf /tmp/kafka-streams/glm-runup-local
