resource "aws_ecs_task_definition" "this" {
  family             = var.family
  execution_role_arn = var.execution_role_arn

  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.cpu
  memory                   = var.memory
  container_definitions    = var.container_definitions
}
