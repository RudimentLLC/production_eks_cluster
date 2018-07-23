KUBECONFIG?="~/.kube/config.eks"

install:
	terraform apply
	cp -f kubeconfig_* $(KUBECONFIG)
	kubectl apply -f config-map-aws-auth_*.yaml
	$(MAKE) -C addons/helm install
	LOG_GROUP_NAME=$(shell terraform output log_group_name) $(MAKE) -C addons/logging install
	$(MAKE) -C addons/prometheus install
	$(MAKE) -C addons/sso install

uninstall:
	$(MAKE) -C addons/sso uninstall
	$(MAKE) -C addons/prometheus uninstall
	$(MAKE) -C addons/logging uninstall
	$(MAKE) -C addons/helm uninstall

.PHONY: install uninstall
