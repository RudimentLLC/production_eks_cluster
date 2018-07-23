install:
	kubectl apply -f service_account.yaml
	kubectl apply -f role_binding.yaml
	helm init --wait --service-account tiller

uninstall:
	kubectl delete -f role_binding.yaml
	kubectl delete -f service_account.yaml

.PHONY: install uninstall
