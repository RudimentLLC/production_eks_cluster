.EXPORT_ALL_VARIABLES:

init:
	terraform init

create:
	terraform apply -auto-approve

destroy:
	terraform destroy -force
	rm -rf ./.terraform *tfstate*

output:
	terraform output

.PHONY: init create destroy output
