output "subnet_id" {
  value = [
    for subnet in aws_subnet.aws_subnet : subnet.id
  ]
}
output "route_table_id" {
  value = var.create_route_table == true ? aws_route_table.aws_route_table[0].id : var.route_table_id
}
