# EKS Cluster
This example shows how one can integrate the [AWS VPC](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws) and [AWS EKS](https://registry.terraform.io/modules/terraform-aws-modules/eks/aws) modules to get a working Kubernetes cluster in AWS. 


## Requirements

* MacOS or Linux is required locally; this workflow has not been tested nor will it be supported on Windows.
* [AWS Authentication](https://www.terraform.io/docs/providers/aws/index.html#authentication) setup on your local machine
* [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) (>= v1.10.4) installed and in your local machine's PATH
* [Heptio Authenticator](https://github.com/heptio/authenticator) (>= v0.3.0) installed and in your local machine's PATH. Currently, this binary needs to be renamed to `aws-iam-authenticator` after being placed in your PATH.
* [Helm](https://github.com/kubernetes/helm) (>=v2.9.0) installed and in your local machine's PATH.
* [Local Tiller plugin](https://github.com/rimusz/helm-tiller) for Helm installed, and port 44134 available.
* Configured Variables:
  * Some of these are environment variables, and some are Terraform variables. Environment variables can be set with `export VARNAME=value`, and Terraform files can be specified in a few different ways: manually when Terraform prompts you, as `var_name = "value"` in a `terraform.tfvars` file, or as environment variables via `export TF_VAR_var_name=value`.

| Variable | Type | Required? | Description |
|---|---|---|---|
| `KUBECONFIG` | Environment | Required | Tells `kubectl` where your configuration should reside. We recommend setting it to a value like `$HOME/.kube/config.eks`. |
| `AWS_ACCESS_KEY_ID` | Environment | Required | Your AWS access key. |
| `AWS_SECRET_ACCESS_KEY` | Environment | Required | Your AWS secret access key. |
| `TERRAFORM_ADMIN_ROLE_ARN` | Environment | Recommended | The ARN of the AWS IAM role that Terraform will use to provision AWS resources. This value will be output after creating Terraform admin resources. |
| `REMOTE_STATE_BUCKET_NAME` | Environment | Recommended | The name of the AWS S3 bucket that will be used to store Terraform state remotely. This value will be output after creating Terraform admin resources. |
| `REMOTE_STATE_LOCK_TABLE_NAME` | Environment | Recommended | The name of the AWS DynamoDB table that will be used to provide locking for Terraform state management. This value will be output after creating Terraform admin resources. |
| `REMOTE_STATE_KEY` | Environment | Optional | The name of the path in the S3 bucket at which remote state will be stored. Defaults to `terraform/eks/tfstate`. |
| `REMOTE_STATE_BUCKET_REGION` | Environment | Optional | The region in which the remote state S3 bucket will be created. Defaults to `us-west-2`. |
| `cluster_name` | Terraform | Required | The desired name for the EKS cluster. |
| `terraform_iam_role_arn` | Terraform | Required | The ARN of the AWS IAM role that Terraform will use to manage AWS resources. |
| `aws_access_key` | Terraform | Required | Your AWS access key. Used by the minio addon. |
| `aws_secret_key` | Terraform | Required | Your AWS secret access key. Used by the minio addon. |


### A Note on "Recommended" Variables

Our recommended deployment strategy involves the creation of "Terraform Admin" resources: an AWS IAM role that Terraform will use to manage AWS resources, and an AWS S3 bucket and DynamoDB table to work with Terraform state files remotely.
The former increases the security of your account by limiting Terraform's permissions to those defined within the IAM role, and the latter elminates issues and headaches that stem from keeping your deployment infrastructure files on your local machine.

The installation instructions below will go into more detail, but the general workflow is this:

1. Set "Required" variables and create the Terraform Admin resources
2. Use the outputs from creating Terraform Admin resources to set "Recommended" variables
3. Create the EKS resources

Our instructions proceed according to this recommendation, but if you don't want to make use of them, you don't have to.
You can ignore any instructions geared towards topics like "first run" or "terraform admin," and you can avoid the use of `make` targets that rely upon this administrative infrastructure in favor of running the Terraform commands yourself.


### A Note on the local Tiller plugin

This configuration elects to _not_ install Tiller into the k8s cluster for a couple of reasons: it removes the need for trying to protect and restrict a service account for Tiller, and it's closer to the workflow of the future Helm 3 which will be Tillerless by design and talk directly to the k8s API.  

Instead, we use a helm plugin that runs a Tiller server locally, on your own machine. This local Tiller server talks to the k8s API using the same connection as Helm (as configured by the `kubeconfig` file). Tiller listens on port 44134, so make sure that you aren't running anything else on that port.

We feel that it's important to get accustomed to the workflow of not installing Tiller into your k8s cluster in preparation for Helm v3, and so the local Tiller plugin ought to be managed by the user, not this installation corpus.


## Installation

### Provision Terraform Admin Resources

First, you should create the Terraform Admin resources, which will be used by the Terraform configuration that later stands up the EKS infrastructure.
If you have already created the Terraform Admin IAM role, the remote state S3 bucket, and the state lock DynamoDB table, you can skip to the [Provision EKS Resources](#provision-admin-resources) step.

Run the following command from this directory:

```
make tf_admin_create
```

Once Terraform completes this execution, it will output several values.
Use these values to populate the `REMOTE_STATE_BUCKET_NAME`, `REMOTE_STATE_LOCK_TABLE_NAME`, and `TERRAFORM_ADMIN_ROLE_ARN` environment variables. 

### Provision EKS Resources

Make sure that your terraform backend environment variables are set!
Then, run the following command from this directory:

```
make install
```

Installation takes roughly 10 minutes. At the end, you will be presented with a Kubernetes Dashboard token. Please see the [Dashboard README](addons/dashboard/README.md) for more details.


## Clean Up

You can delete the EKS cluster and all installed addons by running the following:

```
make uninstall
```

You can also delete the Terraform Admin resources by running the following command:

```
make tf_admin_destroy
```

*NOTE*: `make uninstall` is not idempotent. If you encounter any errors during the uninstall process, you must manually uninstall any remaining addons, and then run `terraform destroy` to remove the remaining AWS resources. 
