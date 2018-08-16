# EKS Cluster
This example shows how one can integrate the [AWS VPC](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws) and [AWS EKS](https://registry.terraform.io/modules/terraform-aws-modules/eks/aws) modules to get a working Kubernetes cluster in AWS. 

## Requirements

* MacOS or Linux is required locally; this workflow has not been tested nor will it be supported on Windows.
* [AWS Authentication](https://www.terraform.io/docs/providers/aws/index.html#authentication) setup on your local machine
* [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) (>= v1.10.4) installed and in your local machine's PATH
* [Heptio Authenticator](https://github.com/heptio/authenticator) (>= v0.3.0) installed and in your local machine's PATH. Currently, this binary needs to be renamed to `aws-iam-authenticator` after being placed in your PATH.
* [Helm](https://github.com/kubernetes/helm) (>=v2.9.0) installed and in your local machine's PATH.
* [Local Tiller plugin](https://github.com/rimusz/helm-tiller) for Helm installed, and port 44134 available.
* The following environment variables must be set:
  * `KUBECONFIG` - this tells `kubectl` where your configuration should reside. We recommend setting it to a value like `~/.kube/config.eks`.
  * `AWS_ACCESS_KEY_ID` - your AWS access key.
  * `AWS_SECRET_ACCESS_KEY` - your AWS secret access key.
  * `LOG_GROUP_NAME` - the name for your cluster's log group in AWS Cloudwatch.

### A Note on the local Tiller plugin
This configuration elects to _not_ install Tiller into the k8s cluster for a couple of reasons: it removes the need for trying to protect and restrict a service account for Tiller, and it's closer to the workflow of the future Helm 3 which will be Tillerless by design and talk directly to the k8s API.  

Instead, we use a helm plugin that runs a Tiller server locally, on your own machine. This local Tiller server talks to the k8s API using the same connection as Helm (as configured by the `kubeconfig` file). Tiller listens on port 44134, so make sure that you aren't running anything else on that port.

We feel that it's important to get accustomed to the workflow of not installing Tiller into your k8s cluster in preparation for Helm v3, and so the local Tiller plugin ought to be managed by the user, not this installation corpus.

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
