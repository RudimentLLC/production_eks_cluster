variable "aws_access_key" {
  type = "string"
  description = "Your AWS access key. Used by minio addon."
}

variable "aws_secret_key" {
  type = "string"
  description = "Your AWS secret key. Used by minio addon."
}

variable "cluster_name" {
  type        = "string"
  description = "The name of the cluster and associated resources."
}

variable "terraform_iam_role_arn" {
  type        = "string"
  description = "The ARN of the IAM role through which Terraform can manage AWS resources."
}

variable "aws_region" {
  type        = "string"
  description = "The name of the AWS region to place resources."
  default     = "us-west-2"
}

variable "additional_userdata" {
  type        = "string"
  description = "Userdata to append to the default userdata of EKS worker groups."
  default     = ""
}
