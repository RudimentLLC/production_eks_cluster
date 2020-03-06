provider aws {
  version    = "~>2.41"
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key

  assume_role {
    role_arn     = var.terraform_admin_role_arn
    session_name = "${var.eks_cluster_name}-eks-session"
    external_id  = "${var.terraform_admin_role_arn}-eks"
  }
}
