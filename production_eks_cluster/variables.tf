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

variable "auth0_connection" {
  type        = "string"
  description = "The Auth0 connection."
}

variable "auth0_client_id" {
  type        = "string"
  description = "The client id for Auth0."
}

variable "image_tag" {
  type        = "string"
  default     = "latest"
  description = "Image tag used for sso service."
}
