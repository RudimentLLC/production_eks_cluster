data "aws_availability_zones" "available" {}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "1.46.0"
  name    = "${var.cluster_name}"
  cidr    = "10.0.0.0/16"

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

locals {
  worker_groups = [
    {
      instance_type       = "m4.large"
      additional_userdata = "${var.additional_userdata}"
      subnets             = "${join(",", module.vpc.private_subnets)}"
    },
  ]
}

module "eks" {
  source        = "terraform-aws-modules/eks/aws"
  version       = "1.7.0"
  cluster_name  = "${var.cluster_name}"
  subnets       = "${module.vpc.public_subnets}"
  worker_groups = "${local.worker_groups}"
  vpc_id        = "${module.vpc.vpc_id}"

  tags = {
    Name = "${var.cluster_name}"
  }
}

resource "aws_cloudwatch_log_group" "this" {
  name = "${var.cluster_name}"
}
