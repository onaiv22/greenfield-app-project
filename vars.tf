variable "profile" {}
variable "region" {}
variable "key_name" {}
//variable "vpc_id" {} 
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
