output "cluster_name" {
  value = "${var.cluster_name}"
}

output "terraform_admin_role_arn" {
  value = "${aws_iam_role.terraform_admin_role.arn}"
}

output "remote_state_bucket_name" {
  value = "${aws_s3_bucket.remote_state_bucket.id}"
}

output "remote_state_lock_table_name" {
  value = "${aws_dynamodb_table.remote_state_lock_table.name}"
}
