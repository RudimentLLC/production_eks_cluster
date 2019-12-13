output eks_cluster_name {
  value = var.eks_cluster_name
}

output terraform_admin_role_arn {
  value = aws_iam_role.terraform_admin_role.arn
}

output aws_region {
  value = var.aws_region
}
