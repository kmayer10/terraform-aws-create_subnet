variable "vpc_id" {}
variable "Name" {}
variable "Type" {}
variable "create_route_table" {
  default = false
}
variable "route_table_id" {
  default = null
}
variable "create_nat_route" {
  default = false
}
variable "gateway_id" {
  default = null
}
variable "destination_cidr_block" {
  default = null
}
