module eks {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 7"

  cluster_name              = var.eks_cluster_name
  subnets                   = var.public_subnets
  vpc_id                    = var.vpc_id
  cluster_enabled_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  worker_groups = [
    {
      name                  = "${var.eks_cluster_name}-worker-group"
      instance_type         = "t3.medium"
      additional_userdata   = var.additional_userdata
      subnets               = var.private_subnets
      asg_desired_capacity  = 3
      asg_min_size          = 3
      asg_max_size          = 10
      autoscaling_enabled   = "true"
      protect_from_scale_in = "false"
      tags = [
        {
          key                 = "environment"
          value               = var.eks_cluster_name
          propagate_at_launch = false
        },
        {
          key                 = "workspace"
          value               = terraform.workspace
          propagate_at_launch = false
        }
      ]
    }
  ]

  manage_aws_auth = false

  kubeconfig_aws_authenticator_additional_args = [
    "-r",
    var.terraform_admin_role_arn,
  ]
}

resource aws_cloudwatch_log_group this {
  name = "${var.eks_cluster_name}-eks-logs"
}
