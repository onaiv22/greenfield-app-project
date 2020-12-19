variable "profile" {}
variable "region" {}
variable "key_name" {}
variable "ami" {}

variable "vpc_cidr" {
    type = string
    default = "10.0.0.0/16"
}

variable "project_networks" {
    type = map(any)
}
output "vpc_id" {
  value = module.vpc.vpc_id
}
output "gw_id" {
    value = module.vpc.gw_id
}
output "bastion-sg_id" {
    value = module.subnets.bastion-sg_id
}

output "alb_id" {
    value = module.subnets.alb_id
}

output "nginx_id" {
    value = module.subnets.nginx_id
}

output "lambda_role" {
    value = module.s3-source.lambda_role
}
