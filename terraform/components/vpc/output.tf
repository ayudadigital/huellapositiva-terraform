output id {
  value = aws_vpc.vpc.id
}

output route_table_id {
  value = join(",", aws_route_table.public_route_table.*.id)
}

output vpc_cidr_block {
  value = aws_vpc.vpc.cidr_block
}

output open_cidr_block {
  value = "0.0.0.0/0"
}

output public_subnet_ids {
  value = aws_subnet.public_subnet.*.id
}
