locals {
  codecommit_location = "https://git-codecommit.${data.aws_region.current.name}.amazonaws.com/v1/repos/${var.name}"
  source_location = var.source_type == "CODECOMMIT" ? local.codecommit_location : var.source_location
}
