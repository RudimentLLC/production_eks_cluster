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

.PHONY: install
