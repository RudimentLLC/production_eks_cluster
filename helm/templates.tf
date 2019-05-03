data "template_file" "autoscaling_config" {
  template = "${file("${path.module}/addons/autoscaling/values-template.yaml")}"

  vars = {
    aws_region       = "${var.aws_region}"
    eks_cluster_name = "${var.eks_cluster_name}"
  }
}

resource "local_file" "autoscaling_config_rendered" {
  content  = "${data.template_file.autoscaling_config.rendered}"
  filename = "${path.module}/addons/autoscaling/values.yaml"
}

data "template_file" "minio_config" {
  template = "${file("${path.module}/addons/minio/values-template.yaml")}"

  vars = {
    aws_region            = "${var.aws_region}"
    eks_cluster_name      = "${var.eks_cluster_name}"
    aws_access_key_id     = "${var.aws_access_key_id}"
    aws_secret_access_key = "${var.aws_secret_access_key}"
  }
}

resource "local_file" "minio_config_rendered" {
  content  = "${data.template_file.minio_config.rendered}"
  filename = "${path.module}/addons/minio/values.yaml"
}

data "template_file" "logging_config" {
  template = "${file("${path.module}/addons/logging/values-template.yaml")}"

  vars = {
    aws_region            = "${var.aws_region}"
    eks_cluster_name      = "${var.eks_cluster_name}"
    aws_access_key_id     = "${var.aws_access_key_id}"
    aws_secret_access_key = "${var.aws_secret_access_key}"
  }
}

resource "local_file" "logging_config_rendered" {
  content  = "${data.template_file.logging_config.rendered}"
  filename = "${path.module}/addons/logging/values.yaml"
}
