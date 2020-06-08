for app in liabilities liabilitiesresulting liabilityqueryservice; do
	kafka-topics --bootstrap-server gueaplatkafkatradingtst01:9093 \
	    --list \
	    --command-config /Users/sri01/workspace/grm-scripts/kafka/keystores/${app}-${1:?test or stage}.properties | \
	egrep '(repartition|changelog)' | \
	grep -v ksql | \
	while read; do 
	    kafka-topics --bootstrap-server gueaplatkafkatradingtst01:9093 \
		--command-config /Users/sri01/workspace/grm-scripts/kafka/keystores/${app}-${1:?test or stage}.properties \
		--topic $REPLY \
		 --describe | grep Configs
	 done
done

