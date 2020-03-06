variable aws_account_number {
  type = string
}

variable aws_access_key {
  type = string
}

variable aws_secret_key {
  type = string
}

variable aws_region {
  type    = string
  default = "us-west-2"
}

variable cluster_ca_certificate {
  type = string
}

variable eks_cluster_endpoint {
  type = string
}

variable eks_cluster_name {
  type = string
}

variable terraform_admin_role_arn {
  type = string
}

variable worker_node_iam_role_arn {
  type = string
}
