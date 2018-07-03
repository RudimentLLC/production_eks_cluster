resource "aws_cloudwatch_log_group" "this" {
  name = "${var.cluster_name}-logs"

  provisioner "local-exec" {
    command = <<EOF
    helm repo add quintilesims 'https://raw.githubusercontent.com/nehayward/kubernetes-fluentd-cloudwatch/master/' &&
    helm install quintilesims/fluentd-cloudwatch \
    --set aws.id=$(echo $AWS_ACCESS_KEY) \
    --set aws.secret=$(echo $AWS_SECRET_KEY) \
    --set aws.loggroup=${self.name} \
    --name fluentd
EOF

    environment {
      AWS_ACCESS_KEY = ""
      AWS_SECRET_KEY = ""
    }
  }
}
