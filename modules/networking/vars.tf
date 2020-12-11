variable "vpc_id" {}
variable "networks" {
  type = map(any)
}
variable "gw_id" {}
variable "nat_gateways" {
  type    = list(any)
  default = []
}