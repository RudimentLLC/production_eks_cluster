output "eks_cluster_name" {
  value = "${format("\"%s\"", "${var.eks_cluster_name}")}"
}

output "terraform_admin_role_arn" {
  value = "${format("\"%s\"", "${aws_iam_role.terraform_admin_role.arn}")}"
}

output "remote_state_bucket_name" {
  value = "${format("\"%s\"", "${aws_s3_bucket.remote_state_bucket.id}")}"
}

output "remote_state_lock_table_name" {
  value = "${format("\"%s\"", "${aws_dynamodb_table.remote_state_lock_table.name}")}"
}

output "aws_region" {
  value = "${format("\"%s\"", "${var.aws_region}")}"
}

output "aws_access_key_id" {
  value = "${format("\"%s\"", "${var.aws_access_key_id}")}"
}

output "aws_secret_access_key" {
  value = "${format("\"%s\"", "${var.aws_secret_access_key}")}"
}