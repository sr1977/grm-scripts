#!/bin/bash 

declare -a topics=("orwell-bet-in" "gstp.risk.liabilities.bets.individual.local" "gstp.risk.liabilities.selections.outcomes.local" "gstp.risk.liabilities.queryservice.bysportsbook.local" "gstp.risk.liabilities.queryservice.bysportsbook.windowed.local" "gstp.risk.liabilities.resulting.compositeidlookup.local")

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
