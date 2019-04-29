resource "aws_s3_bucket" "remote_state_bucket" {
  bucket        = "${var.eks_cluster_name}-remote-state"
  acl           = "${var.s3_bucket_acl}"
  region        = "${var.aws_region}"
  force_destroy = true

  versioning = {
    enabled = "${var.s3_bucket_versioning}"
  }
  tags = {
    Name = "${var.eks_cluster_name}"
  }
}

resource "aws_s3_bucket_public_access_block" "remote_state_bucket_access" {
  bucket = "${aws_s3_bucket.remote_state_bucket.id}"

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "remote_state_lock_table" {
  name           = "${var.eks_cluster_name}-remote-state-lock-table"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
