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

variable eks_cluster_name {
  type = string
}

variable terraform_admin_role_arn {
  type = string
}
