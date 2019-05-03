variable "eks_cluster_name" {
  type        = "string"
  description = "The name of the cluster and associated resources."
}

variable "aws_access_key_id" {
  type = "string"
  description = "Your AWS access key. Used by minio addon."
}

variable "aws_secret_access_key" {
  type = "string"
  description = "Your AWS secret key. Used by minio addon."
}

variable "aws_region" {
  type        = "string"
  description = "The name of the AWS region to place resources."
  default     = "us-west-2"
}