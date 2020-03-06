# Carbon EKS Cluster

This EKS cluster deployment is designed to leverage multiple Terraform workspaces, which is important for a couple of reasons:

- Workspaces allow us to group logically-similar components together, meaning that changes to the components of one workspace won't trigger changes across the entire project.
This reduces the potential area of impact, and gives you more control over the "what" and "when" of applying updates.
- Workspaces are necessary for a multiple-step deployment like this one, where later-stage Terraform providers require information from earlier-stage Terraform resources.
Terraform tends to have difficulty handling deployments with this sort of dependency chain, so breaking these steps out into their own workspaces allows us to use Terraform to manage the entire deployment and reduce the need to a human to run any deployment steps.

This deployment is designed for use with Terraform Enterprise, but the solution should still be usable on Terraform Cloud or even Terraform CLI (given a more manual approach to workspace management).

## Overview

The deployment is composed of several subdirectories within this repo, each designed to be deployed into their own workspace and configured through Terraform variables.
Since some workspaces make use of the outputs from other workspaces, there is an order in which they need to be deployed:

1. `terraform-admin/`
    - Creates AWS IAM resources
2. `vpc/`
    - Creates the AWS networking resources used by the EKS cluster and its workers
    - Depends on outputs from `terraform-admin`
3. `cluster/`
    - Creates the raw EKS cluster itself
    - Depends on outputs from `terraform-admin` and `vpc`
4. `aws-cluster-auth/`
    - Applies the configmap for authentication into the EKS cluster
    - Sets up Kubernetes resources required for Helm and Tiller
    - Depends on outputs from `terraform-admin` and `cluster`
5. `helm/`
    - Provisions the EKS cluster with common addons available through Helm
    - Depends on outputs from `terraform-admin`, `cluster`, and `aws-cluster-auth`
    - **WARNING: The Helm resources are not yet well-managed by Terraform.**
        **At this time, it's best to provision the first four workspaces using Terraform and this repository, then manage your Helm resources through [the `helm` CLI tool](https://helm.sh/docs/intro/install/).**
        **Helm 3 is still in its early stages, and the maintainers of the [Helm Terraform provider](https://github.com/terraform-providers/terraform-provider-helm) are awaiting stability before they'll be able to work on a Terraform provider that uses Helm 3.**
        **(See [this Helm issue](https://github.com/terraform-providers/terraform-provider-helm) for reference.)**
        **Helm 3 strips out the need for a Tiller installation and service account, which should make using Helm a simpler experience.**
