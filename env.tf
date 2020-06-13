
variable "region" {
  default = "us-east-1"
}
variable "app-name" {
  default = "devopschallenge"
}
variable "app-backend-image" {
  default = "geovs/bethehero-backend:latest"
}
variable "app-frontend-image" {
  default = "geovs/bethehero-frontend:latest"
}
variable "az_count" {
  default = 2
}
variable "ecs_task_exection_role_name" {
  default = "EcsTaskExecutionRoleDevops"
}
variable "fargate_backend_cpu" {
  default = 512
}
variable "fargate_backend_memory" {
  default = 1024
}
variable "fargate_frontend_cpu" {
  default = 512
}
variable "fargate_frontend_memory" {
  default = 1024
}
variable "frontend_port" {
  default = 3000
}
variable "backend_port" {
  default = 3031
}
variable "app_frontend_count" {
  default = 1
}
variable "app_backend_count" {
  default = 2
}
variable "health_check_path" {
  default = "/"
}
variable "service_discovery_namespace" {
  default = "local"
}
variable "cidrblock" {
  default = "10.1.0.0/16"
}
