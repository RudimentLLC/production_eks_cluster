variable additional_userdata {
  type        = string
  description = "Userdata to append to the default userdata of EKS worker groups."
  default     = ""
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

variable eks_cluster_name {
  type = string
}

variable private_subnets {
  type = list
}

variable public_subnets {
  type = list
}

variable terraform_admin_role_arn {
  type = string
}

variable vpc_id {
  type = string
}
