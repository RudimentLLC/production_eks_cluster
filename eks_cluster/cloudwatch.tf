resource "aws_cloudwatch_log_group" "this" {
  name = "${var.cluster_name}"

  provisioner "local-exec" {
    command = <<EOF
    helm repo add iqvia 'https://raw.githubusercontent.com/nehayward/kubernetes-fluentd-cloudwatch/master/' &&
    helm install iqvia/fluentd-cloudwatch \
    --set aws.access_key=${var.aws_access_key} \
    --set aws.secret_key=${var.aws_secret_key} \
    --set aws.loggroup=${self.name} \
    --name fluentd
EOF
  }

  depends_on = ["null_resource.post-provision"]
}
