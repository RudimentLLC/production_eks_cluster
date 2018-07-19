resource "aws_cloudwatch_log_group" "this" {
  depends_on = ["null_resource.post-provision"]

  # add cloudwatch logging to EKS cluster
  provisioner "local-exec" {
    command = <<EOF
    export KUBECONFIG="${local.kubeconfig-location}"
    helm repo add "iqvia" "https://raw.githubusercontent.com/nehayward/kubernetes-fluentd-cloudwatch/master/"
    helm install "iqvia/fluentd-cloudwatch" --set aws.access_key="${var.aws_access_key}" --set aws.secret_key="${var.aws_secret_key}" --set aws.loggroup="${var.cluster_name}" --name "fluentd"
EOF
  }
}
