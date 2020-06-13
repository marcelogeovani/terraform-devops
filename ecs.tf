resource "aws_ecs_cluster" "this" {
  name = "${local.app_name}-cluster"
}

module "aws_ecs_task_definition_frontend" {
  source             = "./module/task-definition"
  family             = "${local.app_name}-task-frontend"
  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  cpu                = var.fargate_frontend_cpu
  memory             = var.fargate_frontend_memory
  container_definitions = templatefile("./template/container-definition.json", {
    app_image      = aws_ecr_repository.frontend.repository_url
    app_name       = "${local.app_name}-frontend"
    container_name = local.container_frontend_name
    app_port       = var.frontend_port
    fargate_cpu    = var.fargate_frontend_cpu
    fargate_memory = var.fargate_frontend_memory
    region         = var.region
  })

}
module "aws_ecs_task_definition_backend" {
  source             = "./module/task-definition"
  family             = "${local.app_name}-task-backend"
  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  cpu                = var.fargate_backend_cpu
  memory             = var.fargate_backend_memory
  container_definitions = templatefile("./template/container-definition.json", {
    app_image      = aws_ecr_repository.backend.repository_url
    app_name       = "${local.app_name}-backend"
    container_name = local.container_backend_name
    app_port       = var.backend_port
    fargate_cpu    = var.fargate_backend_cpu
    fargate_memory = var.fargate_backend_memory
    region         = var.region
  })

}
resource "aws_ecs_service" "frontend" {
  name            = "${local.app_name}-frontend-service"
  task_definition = module.aws_ecs_task_definition_frontend.ecs_task_definition_arn
  cluster         = aws_ecs_cluster.this.id
  desired_count   = var.app_frontend_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = aws_subnet.private.*.id
    security_groups  = [aws_security_group.ecs_tasks.id]
    assign_public_ip = true
  }
  load_balancer {
    target_group_arn = aws_alb_target_group.frontend.id
    container_name   = local.container_frontend_name
    container_port   = var.frontend_port
  }
  service_registries {
    registry_arn = aws_service_discovery_service.frontend.arn
  }
  depends_on = [aws_iam_role_policy_attachment.ecs_task_execution_role, aws_alb_listener.frontend]

}
resource "aws_ecs_service" "backend" {
  name            = "${local.app_name}-backend-service"
  task_definition = module.aws_ecs_task_definition_backend.ecs_task_definition_arn
  cluster         = aws_ecs_cluster.this.id
  desired_count   = var.app_backend_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = aws_subnet.private.*.id
    security_groups  = [aws_security_group.ecs_tasks.id]
    assign_public_ip = true
  }
  load_balancer {
    target_group_arn = aws_alb_target_group.backend.id
    container_name   = local.container_backend_name
    container_port   = var.backend_port
  }
  service_registries {
    registry_arn = aws_service_discovery_service.backend.arn
  }
  depends_on = [aws_iam_role_policy_attachment.ecs_task_execution_role, aws_alb_listener.backend]

}
