# EKS Cluster
This example shows how one can integrate the [AWS VPC](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws) and [AWS EKS](https://registry.terraform.io/modules/terraform-aws-modules/eks/aws) modules to get a working Kubernetes cluster in AWS. 

## Requirements

* [AWS Authentication](https://www.terraform.io/docs/providers/aws/index.html#authentication) setup on your local machine
* [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) (>= v1.10.4) installed and in your local machine's PATH
* [Heptio Authenticator](https://github.com/heptio/authenticator) (>= v0.3.0) installed and in your local machine's PATH

## Walkthrough
Run the following command(s) from this directory:

1. Initialize Terraform
```console
$ terraform init
Initializing modules
- module.vpc
- module.eks
...

Terraform has been successfully initialized!
```

2. Check the plan
```console
$ terraform plan
...

Plan: 47 to add, 0 to change, 0 to destroy.
```

3. Create the resources
```console
$ terraform apply
...

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes
...

Apply complete! Resources: 47 added, 0 changed, 0 destroyed.
```

4. Configure Kubectl
```console
$ export KUBECONFIG=~/.kube/config.eks
$ cp kubeconfig $KUBECONFIG
$ kubectl apply -f config-map-aws-auth.yaml
configmap "aws-auth" configured
```

# Cleanup 
Run the following command(s) from this directory:
```console
$ terraform destroy
...

Destroy complete! Resources: 47 destroyed.
```
