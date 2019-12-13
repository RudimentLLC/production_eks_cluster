# EKS Helm Addons

Carbon's EKS configuration includes logging, autoscaling, and MinIO via `helm`. We use the Terraform `helm` provider to install these services.

## Dependencies

If running locally, create a `terraform.tfvars` file and paste the following, replacing the blank values for your context:

``` bash
aws_access_key_id        =
aws_secret_access_key    =
aws_region               =
terraform_admin_role_arn =
eks_cluster_name         =
eks_cluster_endpoint     =
cluster_ca_certificate   =
```

## Local Installation

``` bash
terraform apply
```
