output "log_group_name" {
  value = "${aws_cloudwatch_log_group.this.name}"
}

output "ec2_iam_role_name" {
  value = "${module.eks.worker_iam_role_name}"
}
