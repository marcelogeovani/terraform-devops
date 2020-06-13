locals {
  env                     = terraform.workspace
  app_name                = "${var.app-name}-${local.env}"
  container_frontend_name = "${var.app-name}-frontend"
  container_backend_name  = "${var.app-name}-backend"
}
