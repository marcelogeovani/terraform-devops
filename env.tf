variable "region" {}
variable "app-name" {
  default = "devopschallenge"
}
variable "cidrblock" {
  default = "10.1.0.0/16"
}
variable "az_count" {
  default = 2
}
