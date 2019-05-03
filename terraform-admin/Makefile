################################
# Makefile Settings
################################

SHELL := /bin/bash

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
	rm -f ./terraform.tfvars
	touch ./terraform.tfvars
	echo "aws_access_key_id = \"$${AWS_ACCESS_KEY_ID}\"" >> ./terraform.tfvars
	echo "aws_secret_access_key = \"$${AWS_SECRET_ACCESS_KEY}\"" >> ./terraform.tfvars
	echo "eks_cluster_name = \"$${EKS_CLUSTER_NAME}\"" >> ./terraform.tfvars

# --- main ------------------- #

init:
	terraform init

apply:
	terraform apply -auto-approve

destroy:
	terraform destroy -force

# --- utils ------------------ #

output:
	terraform output

clean:
	rm -rf \
		./.terraform \
		./terraform.tfstate \
		./terraform.tfstate.backup \
		./terraform.tfvars

################################


.PHONY: preflight install uninstall check-environment tfvars init create destroy output clean