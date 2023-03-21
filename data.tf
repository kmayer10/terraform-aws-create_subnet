data "aws_availability_zones" "azs" {
  state = "available"
}
data "aws_vpc" "aws_vpc" {
  id = var.vpc_id
}
