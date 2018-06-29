resource "aws_cloudwatch_log_group" "this" {
  name = "${var.cluster_name}-logs"

  provisioner "local-exec" {
    command     = "make install"
    working_dir = "scripts/"

    environment {
      AWS_ACCESS_KEY = ""
      AWS_SECRET_KEY = ""
    }
  }
}
