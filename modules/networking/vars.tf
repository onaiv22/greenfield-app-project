variable "vpc_id" {}
variable "networks" {
  type = map(any)
}
variable "gw_id" {}
variable "nat_gateways" {
  type    = list(any)
  default = []
}


output "public_subnet_id" {
  value = aws_subnet.public_subnets.*.id
}
output "bastion-sg_id" {
    value = aws_security_group.bastion-sg.id
}

output alb_id {
    value = aws_security_group.alb.id
}

output nginx_id {
    value = aws_security_group.nginx.id
}