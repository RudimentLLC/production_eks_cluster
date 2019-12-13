# EKS Cluster

## Dependencies

If running locally, create a `terraform.tfvars` file and paste the following, replacing the blank values for your context:

``` bash
additional_userdata      =
aws_region               =
eks_cluster_name         =
private_subnets          =
public_subnets           =
terraform_admin_role_arn =
vpc_id                   =
```

Variables in `variables.tf` that have default values may be omitted from the tfvars file.

## Local Installation

``` bash
terraform apply
```

## Outputs

This configuration outputs the following values:

- `cluster_ca_certificate`
- `eks_cluster_endpoint`
- `kubeconfig`
- `log_group_name`
- `worker_node_iam_role_arn`
