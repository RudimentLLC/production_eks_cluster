provider aws {
  version = "~>2.41"
  region  = var.aws_region

  assume_role {
    role_arn     = var.terraform_admin_role_arn
    session_name = "${var.eks_cluster_name}-eks-session"
    external_id  = "${var.terraform_admin_role_arn}-eks"
  }
}

data aws_eks_cluster_auth cluster_auth {
  name = var.eks_cluster_name
}

provider kubernetes {
  version = "~> 1.10"

  host                   = var.eks_cluster_endpoint
  cluster_ca_certificate = var.cluster_ca_certificate
  token                  = data.aws_eks_cluster_auth.cluster_auth.token
}
