locals {
  env                     = terraform.workspace
  app_name                = "${var.app-name}-${local.env}"
}
