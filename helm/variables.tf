variable terraform_admin_role_arn {
  type = string
}

variable aws_region {
  type        = string
  description = "The name of the AWS region to place resources."
}

variable eks_cluster_name {
  type        = string
  description = "The name of the cluster and associated resources."
}

variable aws_access_key_id {
  type        = string
  description = "Your AWS access key. Used by minio addon."
}

variable aws_secret_access_key {
  type        = string
  description = "Your AWS secret key. Used by minio addon."
}

variable eks_cluster_endpoint {
  type = string
}

variable cluster_ca_certificate {
  type        = string
  description = "The EKS cluster's CA certificate in PEM format."
}

variable helm_service_account {
  type        = string
  description = "The ServiceAccount that Helm should use to install charts."
}
