variable terraform_admin_role_arn {
  type = string
}

variable eks_cluster_name {
  type = string
}

variable aws_region {
  type = string
}

variable additional_userdata {
  type        = string
  description = "Userdata to append to the default userdata of EKS worker groups."
  default     = ""
}

variable vpc_id {
  type = string
}

variable private_subnets {
  type = list
}

variable public_subnets {
  type = list
}
