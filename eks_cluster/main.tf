data "aws_availability_zones" "available" {}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "1.14.0"

  name = "${var.cluster_name}"
  cidr = "10.0.0.0/16"

  azs = [
    "${data.aws_availability_zones.available.names[0]}",
    "${data.aws_availability_zones.available.names[1]}",
    "${data.aws_availability_zones.available.names[2]}",
  ]

  private_subnets    = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets     = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    Name                                        = "${var.cluster_name}"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = ">= 1.1.0"

  cluster_name = "${var.cluster_name}"
  subnets      = "${module.vpc.public_subnets}"
  vpc_id       = "${module.vpc.vpc_id}"

  tags = {
    Name = "${var.cluster_name}"
  }
}

resource "null_resource" "post-provision" {
  depends_on = ["module.eks"]

  # configure cluster, install Helm
  provisioner "local-exec" {
    command = <<EOF
    export KUBECONFIG="$HOME/.kube/config.eks"
    cp -f ./kubeconfig $KUBECONFIG
    kubectl cluster-info
    kubectl apply -f config-map-aws-auth.yaml
    kubectl apply -f tiller-service-account.yaml
    kubectl apply -f tiller-cluster-role-binding.yaml
    helm init --wait --service-account tiller
EOF
  }
}
