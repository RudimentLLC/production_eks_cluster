resource "aws_cloudwatch_log_group" "this" {
  name = "${var.cluster_name}-logs"

  provisioner "local-exec" {
    command = <<EOF
    helm repo add iqvia 'https://raw.githubusercontent.com/nehayward/kubernetes-fluentd-cloudwatch/master/' &&
    helm install iqvia/fluentd-cloudwatch \
    --set aws.id=${var.aws_access_id} \
    --set aws.secret=${var.aws_secret_access_key} \
    --set aws.loggroup=${self.name} \
    --name fluentd
EOF
  }
}
