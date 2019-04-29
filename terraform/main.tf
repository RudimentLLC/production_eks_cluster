data "aws_availability_zones" "available" {}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "1.57.0"
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
    Environment                                 = "${var.cluster_name}"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}

locals {
  worker_groups = [
    {
      instance_type         = "t3.medium"
      additional_userdata   = "${var.additional_userdata}"
      subnets               = "${join(",", module.vpc.private_subnets)}"
      asg_desired_capacity  = 2
      asg_min_size          = 2
      asg_max_size          = 10
      autoscaling_enabled   = "true"
      protect_from_scale_in = "false"
    },
  ]

  tags = {
    Environment = "${var.cluster_name}"
    Workspace   = "${terraform.workspace}"
  }
}

module "eks" {
  source        = "terraform-aws-modules/eks/aws"
  version       = "2.2.1"
  cluster_name  = "${var.cluster_name}"
  subnets       = "${module.vpc.public_subnets}"
  worker_groups = "${local.worker_groups}"
  vpc_id        = "${module.vpc.vpc_id}"
  tags          = "${local.tags}"

  kubeconfig_aws_authenticator_additional_args = [
    "-r",
    "${var.terraform_iam_role_arn}",
  ]
}

resource "aws_cloudwatch_log_group" "this" {
  name = "${var.cluster_name}-eks-logs"
}

data "template_file" "autoscaling_config" {
  template = "${file("${path.module}/../addons/autoscaling/values-template.yaml")}"

  vars = {
    aws_region   = "${var.aws_region}"
    cluster_name = "${var.cluster_name}"
  }
}

resource "local_file" "autoscaling_config_rendered" {
  content  = "${data.template_file.autoscaling_config.rendered}"
  filename = "${path.module}/../addons/autoscaling/values.yaml"
}

data "template_file" "minio_config" {
  template = "${file("${path.module}/../addons/minio/values-template.yaml")}"

  vars = {
    aws_region     = "${var.aws_region}"
    cluster_name   = "${var.cluster_name}"
    aws_access_key = "${var.aws_access_key}"
    aws_secret_key = "${var.aws_secret_key}"
  }
}

resource "local_file" "minio_config_rendered" {
  content  = "${data.template_file.minio_config.rendered}"
  filename = "${path.module}/../addons/minio/values.yaml"
}

data "template_file" "logging_config" {
  template = "${file("${path.module}/../addons/logging/values-template.yaml")}"

  vars = {
    aws_region     = "${var.aws_region}"
    cluster_name   = "${var.cluster_name}"
    aws_access_key = "${var.aws_access_key}"
    aws_secret_key = "${var.aws_secret_key}"
  }
}

resource "local_file" "logging_config_rendered" {
  content  = "${data.template_file.logging_config.rendered}"
  filename = "${path.module}/../addons/logging/values.yaml"
}