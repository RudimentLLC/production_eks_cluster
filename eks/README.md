# EKS Cluster
This example shows how one can integrate the [AWS VPC](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws) and [AWS EKS](https://registry.terraform.io/modules/terraform-aws-modules/eks/aws) modules to get a working Kubernetes cluster in AWS. 

## Requirements

* [AWS Authentication](https://www.terraform.io/docs/providers/aws/index.html#authentication) setup on your local machine
* [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) (>= v1.10.4) installed and in your local machine's PATH
* [Heptio Authenticator](https://github.com/heptio/authenticator) (>= v0.3.0) installed and in your local machine's PATH

## Walkthrough
Run the following commands from this directory:

```bash
# always start by running terraform init
$ terraform init
Initializing modules
- module.vpc
- module.eks

...
Terraform has been successfully initialized!

# next, run terraform plan to make sure everything looks correct
$ terraform plan
...
Plan: 47 to add, 0 to change, 0 to destroy.

# assuming everything looks correct, run terraform apply
# this operation takes about 10 minutes to complete
$ terraform apply
...
Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes
...

```
