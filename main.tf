data "aws_availability_zones" "aws_availability_zones" {
  state = "available"
}
data "aws_vpc" "aws_vpc" {
  id = var.vpc_id
}
locals {
  zones = length(data.aws_availability_zones.aws_availability_zones.names)
  cidr  = split(".", data.aws_vpc.aws_vpc.cidr_block)
}
resource "aws_subnet" "aws_subnet" {
  count                   = local.zones
  vpc_id                  = var.vpc_id
  map_public_ip_on_launch = var.type == "private" ? false : true
  availability_zone       = data.aws_availability_zones.aws_availability_zones.names[count.index]
  cidr_block              = "${local.cidr[0]}.${local.cidr[1]}.${var.subnetStartPoint + count.index}.0/24"
  tags = {
    Name = "${var.name}-${var.type}-${var.subnetStartPoint + count.index}"
    Type = var.type
  }
}
resource "aws_route_table" "aws_route_table" {
  count  = var.route_table_needed == true ? 1 : 0
  vpc_id = var.vpc_id
  tags   = {
    Name = "${var.name}-${var.type}-route-table"
  }
}
resource "aws_route_table_association" "aws_route_table_association" {
  count          = local.zones
  route_table_id = var.route_table_needed == true ? aws_route_table.aws_route_table[0].id : var.route_table_id
  subnet_id      = aws_subnet.aws_subnet[count.index].id
}
resource "aws_route" "aws_route" {
  count                  = var.nat_route_needed == false ? 0 : 1
  route_table_id         = var.route_table_needed == true ? aws_route_table.aws_route_table[0].id : var.route_table_id
  gateway_id             = var.gateway_id
  destination_cidr_block = var.destination_cidr_block
}
