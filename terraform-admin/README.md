# Terraform Admin Resources

Carbon's EKS configuration creates an IAM role for subsequent workspaces to use, avoiding the usage of AWS access keys as much as possible.

## Dependencies

If running locally, create a `terraform.tfvars` file and paste the following, replacing the blank values for your context:

``` bash
aws_account_number    =
aws_access_key        =
aws_secret_key        =
aws_region            = "us-west-2"
eks_cluster_name      =
s3_bucket_acl         = "private"
s3_bucket_versioning  = true
```

Variables in `variables.tf` that have default values may be omitted from the tfvars file.

## Local Installation

``` bash
terraform apply
```

## Outputs

This configuration outputs the following values:

- `aws_region`
- `eks_cluster_name`
- `terraform_admin_role_arn`
