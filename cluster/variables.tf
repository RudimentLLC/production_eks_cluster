variable "additional_userdata" {
  type        = "string"
  description = "Userdata to append to the default userdata of EKS worker groups."
  default     = ""
}
variable "aws_region" {
  type        = "string"
  description = "The name of the AWS region to place resources."
  default     = "us-west-2"
}

variable "eks_cluster_name" {
  type        = "string"
  description = "The name of the cluster and associated resources."
}

variable "terraform_admin_role_arn" {
  type        = "string"
  description = "The ARN of the IAM role through which Terraform can manage AWS resources."
}