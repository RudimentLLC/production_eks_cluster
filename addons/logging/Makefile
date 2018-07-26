install: check
	helm install ./fluentd-cloudwatch-0.0.1.tgz \
		--name "fluentd" \
		--set aws.access_key="$(AWS_ACCESS_KEY_ID)" \
		--set aws.secret_key="$(AWS_SECRET_ACCESS_KEY)" \
		--set aws.loggroup="$(LOG_GROUP_NAME)"

uninstall:
	helm del --purge fluentd

check: 
ifeq ($(and $(AWS_ACCESS_KEY_ID),$(AWS_SECRET_ACCESS_KEY),$(LOG_GROUP_NAME)),)
	$(error Set all variables: LOG_GROUP_NAME, AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY)
endif

.PHONY: install uninstall check