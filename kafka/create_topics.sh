#!/bin/bash 

declare -a topics=("orwell-bet-in" "trading.risk.event.local" "gstp.risk.liabilities.bets.individual.local" "gstp.risk.liabilities.selections.outcomes.local" "gstp.risk.liabilities.queryservice.bysportsbook.local" "gstp.risk.liabilities.queryservice.bysportsbook.windowed.local" "gstp.risk.liabilities.resulting.compositeidlookup.local" "gstp.risk.liabilities.bets.total.liabilities.local" "gstp.risk.liabilities.bets.total.liabilities.windowed.local" "gstp.risk.liabilities.resulting.resultedids.local" "risk.alerting.action.local" "gstp.risk.alerting.config.local" "gstp.risk.liabilities.selection.position.local" "gstp.risk.liabilities.selection.multiplecount.local" "gstp.risk.alerting.alerts.local" "bet.trading.glm.runup.total.local" "bet.trading.glm.composites.resulted.local")

options=":d"

while getopts $options opt; do
    case $opt in
        d)
            delete_topics=1
            ;;
        \?)
            stderr Usage: -d to delete topics
            exit 2
            ;;
    esac
done

shift $((OPTIND - 1))


for topic in "${topics[@]}"
do
   if [ -n "$delete_topics" ]; then
       echo "Deleting $topic"
       kafka_utils_delete_topic $topic
   fi
          
   echo "Creating $topic"
   kafka_utils_create_topic $topic
done
