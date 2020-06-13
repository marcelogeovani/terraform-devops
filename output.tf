output "ecs_task_definition_arn_frontend" {
  value = module.aws_ecs_task_definition_frontend.ecs_task_definition_arn
}
output "ecs_task_definition_arn_backend" {
  value = module.aws_ecs_task_definition_backend.ecs_task_definition_arn
}
output "alb_url" {
  value = "${aws_alb.this.dns_name}:3000"
}

