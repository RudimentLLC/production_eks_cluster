################################
# Makefile Settings
################################

SHELL := /bin/bash
REMOTE_STATE_BUCKET_REGION ?= us-west-2
REMOTE_STATE_KEY ?= terraform/eks/tfstate

.EXPORT_ALL_VARIABLES:

################################


################################
# Composite Commands
################################

preflight: check-environment tfvars

install: init apply

uninstall: destroy clean

################################


################################
# Constituent Commands
################################

# --- pre-flight ------------- #

check-environment:
	./scripts/check-environment.bash

tfvars:
	echo -n "" > ./terraform.tfvars
	echo "eks_cluster_name = \"$${EKS_CLUSTER_NAME}\"" >> ./terraform.tfvars
	echo "terraform_admin_role_arn = \"$${TERRAFORM_ADMIN_ROLE_ARN}\"" >> ./terraform.tfvars

# --- main ------------------- #

init:
	terraform init \
		-backend-config="role_arn=${TERRAFORM_ADMIN_ROLE_ARN}" \
		-backend-config="bucket=${REMOTE_STATE_BUCKET_NAME}" \
		-backend-config="dynamodb_table=${REMOTE_STATE_LOCK_TABLE_NAME}" \
		-backend-config="key=${REMOTE_STATE_KEY}" \
		-backend-config="region=${REMOTE_STATE_BUCKET_REGION}"

# The init-r target is useful when you've previously run `terraform init`, but
# something has gone wrong and the previous state bucket is missing or otherwise
# inaccessible. Normally, `terraform init` will attempt to retrieve the previous
# state before updating the backend, but if that fails, terraform will not
# configure a new backend. Using the `-reconfigure` flag instructs terraform to
# not bother with any previous backend configuration.
#
# It is important to note that use of the `-reconfigure` flag WILL NOT PRESERVE
# any state that might have existed in the previous backend!
init-r:
	terraform init \
		-backend-config="role_arn=${TERRAFORM_ADMIN_ROLE_ARN}" \
		-backend-config="bucket=${REMOTE_STATE_BUCKET_NAME}" \
		-backend-config="dynamodb_table=${REMOTE_STATE_LOCK_TABLE_NAME}" \
		-backend-config="key=${REMOTE_STATE_KEY}" \
		-backend-config="region=${REMOTE_STATE_BUCKET_REGION}" \
		-reconfigure

apply:
	terraform apply -auto-approve

destroy:
	terraform destroy -force

# --- utils ------------------ #

plan:
	terraform plan

output:
	terraform output

clean:
	rm -rf \
		./.terraform \
		./terraform.tfvars

################################


.PHONY: init init-r plan apply destroy output clean