# EKS Cluster

This example shows how one can integrate the [AWS VPC](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws) and [AWS EKS](https://registry.terraform.io/modules/terraform-aws-modules/eks/aws) modules to get a working Kubernetes cluster in AWS.

## Requirements

- MacOS or Linux is required locally; this workflow has not been tested nor will it be supported on Windows.
- [AWS Authentication](https://www.terraform.io/docs/providers/aws/index.html#authentication) setup on your local machine
- [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) (>= v1.10.4) installed and in your local machine's PATH
- [Heptio Authenticator](https://github.com/heptio/authenticator) (>= v0.3.0) installed and in your local machine's PATH. Currently, this binary needs to be renamed to `aws-iam-authenticator` after being placed in your PATH.
- [Helm](https://github.com/kubernetes/helm) (>=v2.9.0) installed and in your local machine's PATH.
- [Local Tiller plugin](https://github.com/rimusz/helm-tiller) for Helm installed, and port 44134 available.
- Environment variables.
  - The installation steps will note which variables are required, but the full list of variables used in this repo can be found [below](#environment-variables).

### A Note on the local Tiller plugin

This configuration elects to _not_ install Tiller into the k8s cluster for a couple of reasons: it removes the need for trying to protect and restrict a service account for Tiller, and it's closer to the workflow of the future Helm 3 which will be Tillerless by design and talk directly to the k8s API.

Instead, we use a helm plugin that runs a Tiller server locally, on your own machine. This local Tiller server talks to the k8s API using the same connection as Helm (as configured by the `kubeconfig` file). Tiller listens on port 44134, so make sure that you aren't running anything else on that port.

We feel that it's important to get accustomed to the workflow of not installing Tiller into your k8s cluster in preparation for Helm v3, and so the local Tiller plugin ought to be managed by the user, not this installation corpus.

## Installation

Choose an installation method:

- [Quickstart](#quickstart)
- [Detailed Installation](#detailed-installation)

### Quickstart

1. Set these initial environment variables:
    - `AWS_ACCESS_KEY_ID`
    - `AWS_SECRET_ACCESS_KEY`
    - `EKS_CLUSTER_NAME`

2. From the root level of this repo, run the following command:
    - `make install`

### Detailed Installation

This section breaks down the [Quickstart](#quickstart) method into a couple of smaller steps that are still easy to use.
If you want an even more detailed understanding of this repo, it's recommended that you read and follow the trail of Makefiles throughout the repository.

#### Provision Terraform Admin Resources

First, you should create the Terraform Admin resources, which will be used by the Terraform configuration that later stands up the EKS infrastructure.
If you have already created the Terraform Admin IAM role, the remote state S3 bucket, and the state lock DynamoDB table, you can skip to the [Provision EKS Resources](#provision-eks-resources) step.

Set the following environment variables:

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `EKS_CLUSTER_NAME`

Then, run the following command from this directory:

- `make tf-admin-create`

Once Terraform completes this execution, you can generate an `ENV_VARS` file:

- `make create-env`

This file now contains all the environment variables you'll need for this repository.
You can export them into your shell like so:

- `source ENV_VARS`

#### Provision EKS Resources

Make sure that your terraform backend environment variables are set!
The easiest way is to source the `ENV_VARS` file as noted above.

Run the following command from the root level of this repo:

- `make main-install`

Installation takes roughly 10 minutes.
At the end, you will be presented with a Kubernetes Dashboard token.
Please see the [Dashboard README](addons/dashboard/README.md) for more details.

## Clean Up

You can delete the EKS cluster and the installed addons by running the following:

- `make main-uninstall`

You can also delete the Terraform Admin resources by running the following command:

- `make tf-admin-destroy`

You can delete the local top-level generated files with the following command:

- `make clean`

You can delete all Terraform resources and local Terraform files with the following command:

- `make full-clean`

Finally, you can do all these things together with just one command:

- `make uninstall`

_NOTE_: These cleanup commands are **not all idempotent**.
If you encounter any errors during the uninstall process, you must manually uninstall any remaining addons, and then run `terraform destroy` to remove the remaining AWS resources.

## Environment Variables

Some of these variables are used by Helm, and some are used by Terraform.
To prevent needing to set variables twice, we've opted to set them all only once as environment variables, and then translate as needed into Terraform variables, etc. behind the scenes.

Note the `tf_admin` column - this indicates whether the variable is generated as part of `make tf-admin-create`.

| Variable                       | tf_admin | Description                                                                                                                                                                 |
| ------------------------------ | -------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `AWS_ACCESS_KEY_ID`            |          | The ID of your AWS access key.                                                                                                                                              |
| `AWS_SECRET_ACCESS_KEY`        |          | Your AWS secret access key.                                                                                                                                                 |
| `EKS_CLUSTER_NAME`             |          | The name of your EKS cluster.                                                                                                                                               |
| `KUBECONFIG`                   |          | Tells `kubectl` where your configuration should reside. We recommend setting it to a value like `$HOME/.kube/config.eks`.                                                   |
| `REMOTE_STATE_BUCKET_NAME`     | Yes      | The name of the AWS S3 bucket that will be used to store Terraform state remotely. This value will be output after creating Terraform admin resources.                      |
| `REMOTE_STATE_BUCKET_REGION`   |          | **_Optional._** The region in which the remote state S3 bucket will be created. Defaults to `us-west-2`.                                                                    |
| `REMOTE_STATE_KEY`             |          | **_Optional._** The name of the path in the S3 bucket at which remote state will be stored. Defaults to `terraform/eks/tfstate`.                                            |
| `REMOTE_STATE_LOCK_TABLE_NAME` | Yes      | The name of the AWS DynamoDB table that will be used to provide locking for Terraform state management. This value will be output after creating Terraform admin resources. |
| `TERRAFORM_ADMIN_ROLE_ARN`     | Yes      | The ARN of the AWS IAM role that Terraform will use to provision AWS resources. This value will be output after creating Terraform admin resources.                         |
