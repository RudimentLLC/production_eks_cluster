variable "cluster_name" {
  type        = "string"
  description = "The name of the cluster and associated resources"
}

variable "aws_region" {
  type        = "string"
  description = "The name of the AWS region to place resources"
  default     = "us-west-2"
}
