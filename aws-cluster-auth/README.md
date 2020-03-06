# EKS Cluster Authentication

Normally authentication to an AWS EKS cluster requires the external [aws-iam-authenticator](https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html) binary, but Carbon's EKS configuration makes use of the [aws-eks-cluster-auth](https://www.terraform.io/docs/providers/aws/d/eks_cluster_auth.html) data source to keep the cluster's configuration managed by Terraform.
It also creates authentication resources for post-provisioning with Helm.

## Dependencies

If running locally, create a `terraform.tfvars` file and paste the following, replacing the blank values for your context:

``` bash
aws_account_number       =
aws_access_key           =
aws_secret_key           =
aws_region               = "us-west-2"
cluster_ca_certificate   =
eks_cluster_endpoint     =
eks_cluster_name         =
terraform_admin_role_arn =
worker_node_iam_role_arn =
```

Variables in `variables.tf` that have default values may be omitted from the tfvars file.

## Local Installation

``` bash
terraform apply
```

## Outputs

This configuration outputs the following values:

- `helm_service_account`
