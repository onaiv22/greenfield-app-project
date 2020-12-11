variable "profile" {}
variable "region" {}
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

