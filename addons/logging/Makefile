install:
	helm install "TODO" \
		--name "fluentd" \
		--set aws.access_key="$(AWS_ACCESS_KEY_ID)" \
		--set aws.secret_key="$(AWS_SECRET_ACCESS_KEY)" \ 
		--set aws.loggroup="$(LOG_GROUP_NAME)"

uninstall:
	echo TODO

.PHONY: install uninstall
