MIN_KUBECTL_VERSION="1.10.4"
MIN_HELM_VERSION="2.9.0"
MIN_TILLERLESS_HELM_VERSION="0.2.3"

check_environment:
	./scripts/check-environment.sh ${MIN_KUBECTL_VERSION} ${MIN_HELM_VERSION} ${MIN_TILLERLESS_HELM_VERSION}

tf_init: 
	terraform init

tf_apply:
	terraform apply

tf_destroy:
	terraform destroy

set_kubeconfig:
	cat kubeconfig_* > $(KUBECONFIG)
	kubectl apply -f config-map-aws-auth_*.yaml

install: | check_environment tf_init tf_apply set_kubeconfig tiller_install

tiller_install:
	helm tiller run -- bash -c 'cd $(CURDIR) ; make install_addons'

install_addons:
	$(MAKE) -C addons/logging install
	$(MAKE) -C addons/prometheus install
	$(MAKE) -C addons/sso install
	$(MAKE) -C addons/etcd-operator install
	$(MAKE) -C addons/dashboard install

uninstall: | tiller_uninstall tf_destroy

tiller_uninstall:
	helm tiller run -- bash -c 'cd $(CURDIR) ; make uninstall_addons'

uninstall_addons:
	$(MAKE) -C addons/sso uninstall
	$(MAKE) -C addons/prometheus uninstall
	$(MAKE) -C addons/logging uninstall
	$(MAKE) -C addons/etcd-operator uninstall
	$(MAKE) -C addons/dashboard uninstall

.PHONY: install tiller_install install_addons uninstall tiller_uninstall uninstall_addons tf_apply tf_init set_kubeconfig tf_destroy
