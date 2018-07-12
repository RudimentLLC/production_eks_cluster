variable "cluster_name" {
  type        = "string"
  description = "The name of the cluster and associated resources."
  default     = "test"
}

variable "aws_region" {
  type        = "string"
  description = "The name of the AWS region to place resources."
  default     = "us-west-2"
}

variable "aws_access_key" {
  type        = "string"
  description = "The access id associated with an AWS user."
}

variable "aws_secret_key" {
  type        = "string"
  description = "The access key for the AWS access id."
}
