install:
	helm repo add incubator https://kubernetes-charts-incubator.storage.googleapis.com/
	helm upgrade --install fluentd-cloudwatch incubator/fluentd-cloudwatch -f values.yaml

uninstall:
	-helm delete --purge fluentd-cloudwatch

.PHONY: install uninstall
