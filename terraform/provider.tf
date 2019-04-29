provider "aws" {
  version = "~> 1.60.0"
  region  = "${var.aws_region}"

  assume_role {
    role_arn     = "${var.terraform_admin_role_arn}"
    session_name = "${var.eks_cluster_name}-eks-session"
    external_id  = "${var.terraform_admin_role_arn}-eks"
  }
}
