install: check
	helm repo add incubator https://kubernetes-charts-incubator.storage.googleapis.com/
	helm upgrade --install fluentd-cloudwatch incubator/fluentd-cloudwatch \
		--set awsAccessKeyId="$(AWS_ACCESS_KEY_ID)" \
		--set awsSecretAccessKey="$(AWS_SECRET_ACCESS_KEY)" \
		--set logGroupName="$(LOG_GROUP_NAME)"

uninstall:
	-helm delete --purge fluentd-cloudwatch

check: 
ifeq ($(and $(AWS_ACCESS_KEY_ID),$(AWS_SECRET_ACCESS_KEY),$(LOG_GROUP_NAME)),)
	$(error Set all environment variables: LOG_GROUP_NAME, AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY)
endif

.PHONY: install uninstall check
