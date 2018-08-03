# Set PATH to include local dir for locally downloaded binaries.
export PATH := .:$(PATH)

KUBECONFIG?="~/.kube/config.eks"

install: check-env
	terraform apply
	cp -f kubeconfig_* $(KUBECONFIG)
	kubectl apply -f config-map-aws-auth_*.yaml
	$(MAKE) -C addons/helm install
	$(MAKE) -C addons/dashboard install
	$(MAKE) -C addons/logging install
	$(MAKE) -C addons/prometheus install
	$(MAKE) -C addons/etcd install
	$(MAKE) -C addons/sso install

uninstall:
	$(MAKE) -C addons/helm uninstall
	$(MAKE) -C addons/logging uninstall
	$(MAKE) -C addons/prometheus uninstall
	$(MAKE) -C addons/etcd uninstall
	$(MAKE) -C addons/sso uninstall

.PHONY: install uninstall
