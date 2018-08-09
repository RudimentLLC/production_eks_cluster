tf_init: 
	terraform init

tf_apply:
	terraform apply

tf_destroy:
	terraform destroy

set_kubeconfig:
	cat kubeconfig_* > $(KUBECONFIG)
	kubectl apply -f config-map-aws-auth_*.yaml

install: | tf_init tf_apply set_kubeconfig
	$(MAKE) -C addons/helm install
	$(MAKE) -C addons/logging install
	$(MAKE) -C addons/prometheus install
	$(MAKE) -C addons/sso install
	$(MAKE) -C addons/etcd-operator install
	$(MAKE) -C addons/dashboard install

# WARNING: uninstall-addons is not idempotent 
# https://github.com/quintilesims/production_eks_cluster/issues/20
uninstall-addons:
	$(MAKE) -C addons/sso uninstall
	$(MAKE) -C addons/prometheus uninstall
	$(MAKE) -C addons/logging uninstall
	$(MAKE) -C addons/etcd-operator uninstall
	$(MAKE) -C addons/helm uninstall
	$(MAKE) -C addons/dashboard uninstall

uninstall: | uninstall-addons tf_destroy

.PHONY: install uninstall uninstall-addons tf_apply tf_init set_kubeconfig tf_destroy
