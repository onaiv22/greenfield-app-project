variable "vpc_cidr" {}

output vpc_id {
  value = aws_vpc.main.id
}
output gw_id {
  value = aws_internet_gateway.main.id
}