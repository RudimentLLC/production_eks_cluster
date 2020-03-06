# EKS Helm Addons

Carbon's EKS configuration includes logging, autoscaling, and MinIO via `helm`. We use the Terraform `helm` provider to install these services.

## Dependencies

If running locally, create a `terraform.tfvars` file and paste the following, replacing the blank values for your context:

``` bash
aws_access_key           =
aws_secret_key           =
aws_region               = "us-west-2"
eks_cluster_endpoint     =
eks_cluster_name         =
cluster_ca_certificate   =
terraform_admin_role_arn =
```

## Local Installation

``` bash
terraform apply
```
