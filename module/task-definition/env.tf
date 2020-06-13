variable "region" {
  default = "us-east-1"
}
variable "family" {
  default = "devopschallenge"
}
variable "cpu" {
  default = 512
}
variable "memory" {
  default = 1024
}
variable "app_port" {
  default = 3000
}
variable "container_name" {
  default = "devopschallenge"
}
variable "app_image" {
  default = ""
}
variable "container_definitions" {
  default = ""
}
variable "execution_role_arn" {
  default = ""
}
