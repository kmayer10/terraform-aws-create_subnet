locals {
  count = length(data.aws_availability_zones.azs.names)
  cidr  = split(".", data.aws_vpc.aws_vpc.cidr_block)
}
