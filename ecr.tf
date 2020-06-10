resource "aws_ecr_repository" "backend" {
  name = "${local.app_name}-backend"
}
resource "null_resource" "backend" {
  provisioner "local-exec" {
    command = "$(aws ecr get-login --no-include-email --region ${var.region})"
  }
  provisioner "local-exec" {
    command = "docker pull ${var.app-backend-image}"
  }
  provisioner "local-exec" {
    command = "docker tag  ${var.app-backend-image} ${aws_ecr_repository.backend.repository_url}:latest"
  }
  provisioner "local-exec" {
    command = "docker push ${aws_ecr_repository.backend.repository_url}:latest"
  }
}


resource "aws_ecr_repository" "frontend" {
  name = "${local.app_name}-frontend"
}

resource "null_resource" "frontend" {
  provisioner "local-exec" {
    command = "$(aws ecr get-login --no-include-email --region ${var.region})"
  }
  provisioner "local-exec" {
    command = "docker pull ${var.app-frontend-image}"
  }
  provisioner "local-exec" {
    command = "docker tag ${var.app-frontend-image} ${aws_ecr_repository.frontend.repository_url}:latest"
  }
  provisioner "local-exec" {
    command = "docker push ${aws_ecr_repository.frontend.repository_url}:latest"
  }
}
