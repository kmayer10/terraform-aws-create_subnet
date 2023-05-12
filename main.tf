data "aws_availability_zones" "aws_availability_zones" {
  state = "available"
}
data "aws_vpc" "aws_vpc" {
  id = var.vpc_id
}
data "aws_subnets" "aws_subnets" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}
locals {
  count           = length(data.aws_availability_zones.aws_availability_zones.names)
  current_subnets = length(data.aws_subnets.aws_subnets.ids)
  cidr            = split(".", data.aws_vpc.aws_vpc.cidr_block)
}
resource "aws_subnet" "aws_subnet" {
  count                   = local.count
  vpc_id                  = var.vpc_id
  availability_zone       = data.aws_availability_zones.aws_availability_zones.names[count.index]
  cidr_block              = "${local.cidr[0]}.${local.cidr[1]}.${local.current_subnets + count.index}.0/24"
  map_public_ip_on_launch = var.type == "private" ? false : true
  tags = {
    Name = var.Name
    type = var.type
  }
}
resource "aws_route_table" "aws_route_table" {
  count  = var.create_route_table == true ? 1 : 0
  vpc_id = var.vpc_id
  tags = {
    Name = var.Name
  }
}
resource "aws_route_table_association" "aws_route_table_association" {
  count          = local.count
  route_table_id = var.create_route_table == true ? aws_route_table.aws_route_table[0].id : var.route_table_id
  subnet_id      = aws_subnet.aws_subnet[count.index].id
}
resource "aws_route" "nat" {
  count                  = var.create_nat_route == true ? 1 : 0
  route_table_id         = var.create_route_table == true ? aws_route_table.aws_route_table[0].id : var.route_table_id
  gateway_id             = var.gateway_id
  destination_cidr_block = var.destination_cidr_block
}
