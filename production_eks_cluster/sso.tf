resource "null_resource" "sso" {
  depends_on = ["null_resource.post-provision"]

  # add SSO to EKS cluster
  provisioner "local-exec" {
    command = <<EOF
    export KUBECONFIG="${local.kubeconfig-location}"
    helm repo add "iqvia" "https://raw.githubusercontent.com/quintilesims/eks-sso/master/"
    helm install "iqvia/eks-sso" --set auth0.connection="${var.auth0_connection}" --set auth0.client_id="${var.auth0_client_id}" --set image.tag="${var.image_tag}" --set sso.name="${var.cluster_name}" --name "eks-sso"
EOF
  }
}
