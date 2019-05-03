################################
# Makefile Settings
################################

SHELL := /bin/bash
KUBECONFIG ?= $${HOME}/.kube/config.eks

.EXPORT_ALL_VARIABLES:

################################


################################
# Complete Setup/Teardown
################################

install:
	$(MAKE) tf-admin-create
	$(MAKE) create-vars
	source ./ENV_VARS && $(MAKE) main-install

uninstall:
	$(MAKE) main-uninstall
	$(MAKE) tf-admin-destroy
	$(MAKE) clean

################################


################################
# Terraform Admin
################################

tf-admin-create:
	$(MAKE) -C terraform-admin/ preflight
	$(MAKE) -C terraform-admin/ install

tf-admin-destroy:
	$(MAKE) -C terraform-admin/ uninstall

################################


################################
# EKS Cluster
################################

main-install:
	$(MAKE) -C helm/ preflight
	$(MAKE) -C cluster/ preflight
	$(MAKE) -C cluster/ install
	$(MAKE) set-kubeconfig
	$(MAKE) -C helm/ install

main-uninstall:
	$(MAKE) -C helm/ uninstall
	$(MAKE) -C cluster/ uninstall

################################


################################
# Utils
################################

set-kubeconfig:
	cat cluster/kubeconfig_* > ${KUBECONFIG}
	kubectl apply -f cluster/config-map-aws-auth_*.yaml

create-vars:
	echo -n "" > ./ENV_VARS
	echo "export KUBECONFIG=${KUBECONFIG}" >> ./ENV_VARS
	echo "export EKS_CLUSTER_NAME=$(shell terraform output -state=terraform-admin/terraform.tfstate eks_cluster_name)" >> ./ENV_VARS
	echo "export TERRAFORM_ADMIN_ROLE_ARN=$(shell terraform output -state=terraform-admin/terraform.tfstate terraform_admin_role_arn)" >> ./ENV_VARS
	echo "export REMOTE_STATE_BUCKET_NAME=$(shell terraform output -state=terraform-admin/terraform.tfstate remote_state_bucket_name)" >> ./ENV_VARS
	echo "export REMOTE_STATE_LOCK_TABLE_NAME=$(shell terraform output -state=terraform-admin/terraform.tfstate remote_state_lock_table_name)" >> ./ENV_VARS
	echo "export AWS_REGION=$(shell terraform output -state=terraform-admin/terraform.tfstate aws_region)" >> ./ENV_VARS
	echo "export AWS_ACCESS_KEY_ID=$(shell terraform output -state=terraform-admin/terraform.tfstate aws_access_key_id)" >> ./ENV_VARS
	echo "export AWS_SECRET_ACCESS_KEY=$(shell terraform output -state=terraform-admin/terraform.tfstate aws_secret_access_key)" >> ./ENV_VARS

clean:
	rm -f ./ENV_VARS

full-clean:
	rm -rf ./ENV_VARS
	$(MAKE) -C cluster/ clean
	$(MAKE) -C helm/ clean
	$(MAKE) -C terraform-admin/ clean

################################


.PHONY: install uninstall tf-admin-create tf-admin-destroy main-install main-uninstall set-kubeconfig create-vars clean full-clean