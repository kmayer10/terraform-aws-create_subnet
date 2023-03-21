variable "vpc_id" {
  description = "Enter the ID of VPC where subnets needs to be created."
}
variable "subnet_counter" {
  description = "Enter the Number to be used as third digit of subnet CIDR value calculation."
}
variable "name" {
  description = "Value to be used for Name Tag"
}
variable "subnet_type" {
  description = "Enter Subnet Type, Select from: private/public"
}
