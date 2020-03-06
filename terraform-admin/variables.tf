variable aws_account_number {
  type = string
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

# We have to choose from a list of canned ACLs, and "private" seems to
# be the safest. See the following links for more information.
# https://www.terraform.io/docs/providers/aws/r/s3_bucket.html#acl
# https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#canned-acl
variable s3_bucket_acl {
  type    = string
  default = "private"
}

variable s3_bucket_versioning {
  type    = string
  default = true
}
