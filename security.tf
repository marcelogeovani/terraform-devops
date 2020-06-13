resource "aws_security_group" "ecs_tasks" {
  name        = "${local.app_name}-ecs-task"
  description = "access from ALB"
  vpc_id      = aws_vpc.this.id
  ingress {
    from_port   = var.frontend_port
    protocol    = "tcp"
    to_port     = var.frontend_port
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = var.backend_port
    protocol    = "tcp"
    to_port     = var.backend_port
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]

  }
}
