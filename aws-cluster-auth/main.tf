data aws_iam_policy_document kubectl_assume_role_policy {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.aws_account_number}:root"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource aws_iam_role eks_kubectl_role {
  name               = "${var.eks_cluster_name}-kubectl-access-role"
  assume_role_policy = data.aws_iam_policy_document.kubectl_assume_role_policy.json
}

resource aws_iam_role_policy_attachment eks_kubectl_cluster {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_kubectl_role.name
}

resource aws_iam_role_policy_attachment eks_kubectl_service {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.eks_kubectl_role.name
}

resource aws_iam_role_policy_attachment eks_kubectl_worker_node {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_kubectl_role.name
}

resource kubernetes_config_map aws_auth {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapRoles = <<YAML
  - rolearn: ${var.worker_node_iam_role_arn}
    username: system:node:{{EC2PrivateDNSName}}
    groups:
      - system:bootstrappers
      - system:nodes
  - rolearn: ${aws_iam_role.eks_kubectl_role.arn}
    username: kubectl-access-user
    groups:
      - system:masters
  YAML
  }
}
