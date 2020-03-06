# EKS VPC Resources

Carbon's EKS configuration runs on top of AWS VPC networking resources.

## Dependencies

If running locally, create a `terraform.tfvars` file and paste the following, replacing the blank values for your context:

``` bash
aws_access_key           =
aws_secret_key           =
aws_region               = "us-west-2"
eks_cluster_name         =
terraform_admin_role_arn =
```

Variables in `variables.tf` that have default values may be omitted from the tfvars file.

## Local Installation

``` bash
terraform apply
```

## Outputs

This configuration outputs the following values:

- `private_subnets`
- `public_subnets`
- `vpc_id`
