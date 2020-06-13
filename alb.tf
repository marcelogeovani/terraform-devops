resource "aws_alb" "this" {
  name            = "${local.app_name}-alb"
  subnets         = aws_subnet.public.*.id
  security_groups = [aws_security_group.ecs_tasks.id]
}

resource "aws_alb_target_group" "frontend" {
  name        = "${local.app_name}-frontend"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.this.id
  target_type = "ip"
  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = var.health_check_path
    unhealthy_threshold = "2"
  }
}
resource "aws_alb_listener" "frontend" {
  load_balancer_arn = aws_alb.this.id
  port              = var.frontend_port
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_alb_target_group.frontend.id
    type             = "forward"
  }
}
resource "aws_alb_target_group" "backend" {
  name        = "${local.app_name}-backend"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.this.id
  target_type = "ip"
  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = var.health_check_path
    unhealthy_threshold = "2"
  }
}
resource "aws_alb_listener" "backend" {
  load_balancer_arn = aws_alb.this.id
  port              = var.backend_port
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_alb_target_group.backend.id
    type             = "forward"
  }
}
