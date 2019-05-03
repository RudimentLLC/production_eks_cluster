################################
# Makefile Settings
################################

SHELL := /bin/bash

.EXPORT_ALL_VARIABLES:

################################


################################
# Composite Commands
################################

preflight: check-environment helm-update tfvars

install: init apply tiller-install

uninstall: tiller-uninstall destroy clean

################################


################################
# Constituent Commands
################################

# --- pre-flight ------------- #

check-environment:
	./scripts/check-environment.bash ${MIN_KUBECTL_VERSION} ${MIN_HELM_VERSION} ${MIN_TILLERLESS_HELM_VERSION}

helm-update:
	helm repo add incubator https://kubernetes-charts-incubator.storage.googleapis.com/
	helm repo update

tfvars:
	echo -n "" > terraform.tfvars
	echo "eks_cluster_name = \"$${EKS_CLUSTER_NAME}\"" >> terraform.tfvars
	echo "aws_access_key_id = \"$${AWS_ACCESS_KEY_ID}\"" >> terraform.tfvars
	echo "aws_secret_access_key = \"$${AWS_SECRET_ACCESS_KEY}\"" >> terraform.tfvars
	echo "aws_region = \"$${AWS_REGION}\"" >> terraform.tfvars

# --- terraform -------------- #

init:
	terraform init

apply:
	terraform apply -auto-approve

destroy:
	terraform destroy -force

# --- provision with tiller -- #

tiller-install:
	helm tiller run -- bash -c 'cd $(CURDIR) ; make install-addons'

tiller-uninstall:
	helm tiller run -- bash -c 'cd $(CURDIR) ; make uninstall-addons'

# --- helm addons ------------ #

install-addons:
	$(MAKE) -C addons/autoscaling/ install
	$(MAKE) -C addons/logging/ install
	$(MAKE) -C addons/prometheus/ install
	$(MAKE) -C addons/etcd-operator/ install
	$(MAKE) -C addons/dashboard/ install
	$(MAKE) -C addons/minio/ install

uninstall-addons:
	$(MAKE) -C addons/prometheus/ uninstall
	$(MAKE) -C addons/logging/ uninstall
	$(MAKE) -C addons/etcd-operator/ uninstall
	$(MAKE) -C addons/dashboard/ uninstall
	$(MAKE) -C addons/minio/ uninstall
	$(MAKE) -C addons/autoscaling/ uninstall

# --- utils ------------------ #

clean:
	rm -rf \
		.terraform \
		terraform.tfstate \
		terraform.tfstate.backup \
		terraform.tfvars

################################


.PHONY: check-environment helm-update tfvars init apply destroy set-kubeconfig tiller-install tiller-uninstall install-addons uninstall-addons clean