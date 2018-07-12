resource "null_resource" "sso" {
  # add sso to cluster
  name = "${var.cluster_name}"

  provisioner "local-exec" {
    command = <<EOF
    helm repo add iqvia 'https://raw.githubusercontent.com/quintilesims/eks-sso/master/'
    helm install iqvia/eks-sso \
    --set auth0.connection=${var.auth0_connection} \
    --set auth0.client_id=${var.auth0_client_id} \  
    --set sso.name=${self.name} \
    --name eks-sso
EOF
  }

  depends_on = ["null_resource.post-provision"]
}
