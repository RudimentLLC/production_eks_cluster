output log_group_name {
  value = aws_cloudwatch_log_group.this.name
}

output kubeconfig {
  value = module.eks.kubeconfig
}

output eks_cluster_endpoint {
  value = module.eks.cluster_endpoint
}

output cluster_ca_certificate {
  value = base64decode(module.eks.cluster_certificate_authority_data)
}

output worker_node_iam_role_arn {
  value = module.eks.worker_iam_role_arn
}
