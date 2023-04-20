variable "name" {}
variable "type" {
  default = "private"
}
variable "vpc_id" {}
variable "subnetStartPoint" {}
variable "route_table_needed" {
  default = false
}
variable "route_table_id" {
  default = null
}
variable "nat_route_needed" {
  default = false
}
variable "gateway_id" {
  default = null
}
variable "destination_cidr_block" {
  default = "0.0.0.0/0"
}
