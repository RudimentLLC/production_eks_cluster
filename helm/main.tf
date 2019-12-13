# Helm Chart Repositories
# see: https://www.terraform.io/docs/providers/helm/release.html
// data helm_repository stable {
//   name = "stable"
//   url  = "https://kubernetes-charts.storage.googleapis.com"
// }

// data helm_repository incubator {
//   name = "incubator"
//   url  = "https://kubernetes-charts-incubator.storage.googleapis.com"
// }

# Autoscaling Configuration
# see: `/addons/autoscaling` for config template
// resource helm_release carbon-autoscaling {
//   name       = "autoscaler"
//   repository = data.helm_repository.stable.metadata[0].name
//   chart      = "cluster-autoscaler"
//   namespace  = "kube-system"

//   values = [
//     file("./addons/autoscaling/values-template.yaml")
//   ]

//   set_string {
//     name  = "awsRegion"
//     value = var.aws_region
//   }

//   set_string {
//     name  = "autoDiscovery.clusterName"
//     value = var.eks_cluster_name
//   }

//   set_string {
//     name  = "awsAccessKeyID"
//     value = var.aws_access_key_id
//   }

//   set_string {
//     name  = "awsSecretAccessKey"
//     value = var.aws_secret_access_key
//   }

//   set {
//     name  = "rbac.create"
//     value = "true"
//   }

//   set_string {
//     name  = "cloudProvider"
//     value = "aws"
//   }
// }

# # Minio Configuration
# # see: `/addons/minio` for config template
# resource helm_release minio {
#   name       = "carbon-minio"
#   repository = data.helm_repository.stable.metadata[0].name
#   chart      = "minio"
#   namespace  = "kube-system"

#   values = [
#     file("./addons/minio/values-template.yaml"),
#   ]

#   set_string {
#     name  = "accessKey"
#     value = var.aws_access_key_id
#   }

#   set_string {
#     name  = "secretKey"
#     value = var.aws_secret_access_key
#   }

#   set_string {
#     name  = "defaultBucket.name"
#     value = "${var.eks_cluster_name}-minio"
#   }

#   set_string {
#     name  = "environment.AWS_ACCESS_KEY_ID"
#     value = var.aws_access_key_id
#   }

#   set_string {
#     name  = "environment.AWS_SECRET_ACCESS_KEY"
#     value = var.aws_secret_access_key
#   }
# }

# # Logging Configuration
# # see: `/addons/logging` for config template
# resource helm_release carbon-logging {
#   name       = "logging"
#   repository = data.helm_repository.incubator.metadata[0].name
#   chart      = "fluentd-cloudwatch"
#   namespace  = "kube-system"

#   values = [
#     file("./addons/logging/values-template.yaml"),
#   ]

#   set_string {
#     name  = "awsAccessKeyId"
#     value = var.aws_access_key_id
#   }

#   set_string {
#     name  = "awsSecretAccessKey"
#     value = var.aws_secret_access_key
#   }

#   set_string {
#     name  = "awsRegion"
#     value = var.aws_secret_access_key
#   }

#   set_string {
#     name  = "logGroupName"
#     value = "${var.eks_cluster_name}-eks-logs"
#   }
# }
