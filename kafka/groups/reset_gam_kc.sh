kafka-consumer-groups \
	--bootstrap-server localhost:9092  \
        --all-groups \
        --reset-offsets \
        --execute \
        --topic gstp.risk.alerting.operation.local \
        --shift-by 1


