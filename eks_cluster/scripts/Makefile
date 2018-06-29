init: 
	terraform init
	terraform apply --auto-approve
	helm repo add quintilesims 'https://raw.githubusercontent.com/quintilesims/kubernetes-fluentd-cloudwatch/master/'

install: check-env 
	helm install quintilesims/fluentd-cloudwatch --set aws.id=$(echo $AWS_ACCESS_KEY) --set aws.secret=$(echo $AWS_SECRET_KEY) --set aws.loggroup=\"$(terraform output cluster_name)-logs\" --name fluentd

uninstall: 
	helm del --purge fluentd
	terraform destroy

check-env:
ifndef AWSKEY
  $(error AWS_ACCESS_KEY is undefined)
endif
ifndef AWSID
  $(error AWS_SECRET_KEY is undefined)
endif

.PHONY: install check-env init uninstall
