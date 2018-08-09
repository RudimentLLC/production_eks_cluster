# EKS Cluster
This example shows how one can integrate the [AWS VPC](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws) and [AWS EKS](https://registry.terraform.io/modules/terraform-aws-modules/eks/aws) modules to get a working Kubernetes cluster in AWS. 

## Requirements

* MacOS or Linux is required locally; this workflow has not been tested nor will it be supported on Windows.
* [AWS Authentication](https://www.terraform.io/docs/providers/aws/index.html#authentication) setup on your local machine
* [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) (>= v1.10.4) installed and in your local machine's PATH
* [Heptio Authenticator](https://github.com/heptio/authenticator) (>= v0.3.0) installed and in your local machine's PATH. Currently, this binary needs to be renamed to `aws-iam-authenticator` after being placed in your PATH.
* [Helm](https://github.com/kubernetes/helm) (>=v2.9.0) installed and in your local machine's PATH.
* The following environment variables must be set:
  * `KUBECONFIG` - this tells `kubectl` where your configuration should reside. We recommend setting it to a value like `~/.kube/config.eks`.
  * `AWS_ACCESS_KEY_ID` - your AWS access key.
  * `AWS_SECRET_ACCESS_KEY` - your AWS secret access key.
  * `LOG_GROUP_NAME` - the name for your cluster's log group in AWS Cloudwatch.

## Installation

Run the following command from this directory:

```
make install
```

Installation takes roughly 10 minutes. At the end, you will be presented with a Kubernetes Dashboard token. Please see the [Dashboard README](addons/dashboard/README.md) for more details.

## Clean Up

You can delete the EKS cluster and all installed addons by running the following:

```
make uninstall
```

*NOTE*: `make uninstall` is not idempotent. If you encounter any errors during the uninstall process, you must manually uninstall any remaining addons, and then run `terraform destroy` to remove the remaining AWS resources. 
