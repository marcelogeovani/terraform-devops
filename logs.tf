resource "aws_cloudwatch_log_group" "this" {
  name              = "/ecs/${local.app_name}-frontend"
  retention_in_days = 5
  tags = {
    Name = "${local.app_name}-log-group"
  }
}
resource "aws_cloudwatch_log_stream" "this" {
  name           = "${local.app_name}-log-stream"
  log_group_name = aws_cloudwatch_log_group.this.name
}
resource "aws_cloudwatch_log_group" "backend" {
  name              = "/ecs/${local.app_name}-backend"
  retention_in_days = 5
  tags = {
    Name = "${local.app_name}-log-group-backend"
  }
}
resource "aws_cloudwatch_log_stream" "backend" {
  name           = "${local.app_name}-log-stream"
  log_group_name = aws_cloudwatch_log_group.backend.name
}
