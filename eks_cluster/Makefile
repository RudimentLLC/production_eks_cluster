install:
	cp kubeconfig ${KUBECONFIG}
	kubectl apply -f config-map-aws-auth.yaml
	kubectl apply -f tiller-service-account.yaml
	kubectl apply -f tiller-cluster-role-binding.yaml
	helm init --service-account tiller

uninstall:
	helm ls --short | xargs -L1 helm delete --purge
	helm reset
	terraform destroy

.PHONY: install uninstall
