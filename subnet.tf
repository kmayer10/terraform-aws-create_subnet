resource "aws_subnet" "aws_subnet" {
  count                   = local.count
  vpc_id                  = var.vpc_id
  availability_zone       = data.aws_availability_zones.azs.names[count.index]
  cidr_block              = "${local.cidr[0]}.${local.cidr[1]}.${var.subnet_counter + count.index}.0/24"
  map_public_ip_on_launch = var.subnet_type == "public" ? true : false
  tags = {
    Name = "${var.name}_${var.subnet_type}_${var.subnet_counter + count.index}"
    Type = var.subnet_type
  }
}
