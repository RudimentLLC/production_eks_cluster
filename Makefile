.EXPORT_ALL_VARIABLES:

MIN_KUBECTL_VERSION="1.10.4"
MIN_HELM_VERSION="2.9.0"
MIN_TILLERLESS_HELM_VERSION="0.2.3"


install: check_environment helm_update tf_init tf_apply set_kubeconfig tiller_install

uninstall: tiller_uninstall tf_destroy

check_environment:
	./scripts/check-environment.sh ${MIN_KUBECTL_VERSION} ${MIN_HELM_VERSION} ${MIN_TILLERLESS_HELM_VERSION}

helm_update:
	helm repo add incubator https://kubernetes-charts-incubator.storage.googleapis.com/
	helm repo update

tf_admin_create:
	$(MAKE) -C terraform-admin/ init
	$(MAKE) -C terraform-admin/ create

tf_admin_destroy:
	$(MAKE) -C terraform-admin/ destroy

tf_admin_output:
	$(MAKE) -C terraform-admin/ output

tf_init: 
	$(MAKE) -C terraform/ init

tf_plan:
	$(MAKE) -C terraform/ plan

tf_apply:
	$(MAKE) -C terraform/ apply

tf_destroy:
	$(MAKE) -C terraform/ destroy

tf_output:
	$(MAKE) -C terraform/ output

set_kubeconfig:
	cat terraform/kubeconfig_* > ${KUBECONFIG}
	kubectl apply -f terraform/config-map-aws-auth_*.yaml

tiller_install:
	helm tiller run -- bash -c 'cd $(CURDIR) ; make install_addons'

tiller_uninstall:
	helm tiller run -- bash -c 'cd $(CURDIR) ; make uninstall_addons'

install_addons:
	$(MAKE) -C addons/autoscaling/ install
	$(MAKE) -C addons/logging/ install
	$(MAKE) -C addons/prometheus/ install
	$(MAKE) -C addons/etcd-operator/ install
	$(MAKE) -C addons/minio/ install
	$(MAKE) -C addons/dashboard/ install

uninstall_addons:
	$(MAKE) -C addons/prometheus/ uninstall
	$(MAKE) -C addons/logging/ uninstall
	$(MAKE) -C addons/etcd-operator/ uninstall
	$(MAKE) -C addons/minio/ uninstall
	$(MAKE) -C addons/dashboard/ uninstall
	$(MAKE) -C addons/autoscaling/ uninstall

.PHONY: install uninstall check_environment helm_update tf_admin_create tf_admin_destroy tf_admin_output tf_init tf_plan tf_apply tf_destroy tf_output set_kubeconfig tiller_install tiller_uninstall install_addons uninstall_addons
