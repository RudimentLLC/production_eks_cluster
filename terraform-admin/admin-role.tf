resource aws_iam_role terraform_admin_role {
  name                  = "${var.eks_cluster_name}-terraform-admin"
  force_detach_policies = true
  description           = "Allows Terraform to manage AWS resources for the '${var.eks_cluster_name}' EKS cluster."

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "AWS": "arn:aws:iam::${var.aws_account_number}:root"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF


  tags = {
    Name = var.eks_cluster_name
  }
}

resource aws_iam_policy terraform_admin_policy {
  name        = "${var.eks_cluster_name}-terraform-admin"
  description = "Allows Terraform to manage AWS resources for the '${var.eks_cluster_name}' EKS cluster."

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "*",
      "Resource": "*"
    }
  ]
}
EOF

}

resource aws_iam_policy_attachment terraform_admin_policy_attachment {
  name       = "${var.eks_cluster_name}-terraform-admin"
  roles      = [aws_iam_role.terraform_admin_role.name]
  policy_arn = aws_iam_policy.terraform_admin_policy.arn
}
