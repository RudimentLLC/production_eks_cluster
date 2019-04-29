.EXPORT_ALL_VARIABLES:

REMOTE_STATE_KEY ?= terraform/eks/tfstate
REMOTE_STATE_BUCKET_REGION ?= us-west-2

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

plan:
	terraform plan

apply:
	terraform apply -auto-approve

destroy:
	terraform destroy -force
	rm -rf ./.terraform

output:
	@terraform output

clean:
	rm -rf ./.terraform

.PHONY: init init-r plan apply destroy output clean
