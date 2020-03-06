variable aws_access_key {
  type = string
}

variable aws_secret_key {
  type = string
}

variable aws_region {
  type        = string
  default     = "us-west-2"
  description = "The name of the AWS region to place resources."
}

variable cluster_ca_certificate {
  type        = string
  description = "The EKS cluster's CA certificate in PEM format."
}

variable eks_cluster_endpoint {
  type = string
}

variable eks_cluster_name {
  type        = string
  description = "The name of the cluster and associated resources."
}

variable helm_service_account {
  type        = string
  description = "The ServiceAccount that Helm should use to install charts."
}

variable terraform_admin_role_arn {
  type = string
}
