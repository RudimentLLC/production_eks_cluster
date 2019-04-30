.EXPORT_ALL_VARIABLES:

init:
	terraform init

create:
	terraform apply -auto-approve

destroy:
	terraform destroy -force

output:
	@terraform output

clean:
	rm -rf \
		./.terraform \
		./terraform.tfstate \
		./terraform.tfstate.backup \
		./terraform.tfvars

.PHONY: init create destroy output clean
