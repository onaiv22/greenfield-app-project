variable "name" {}
# variable "port" {}
# variable "protocol" {}
variable "subnets" {}
variable "security_groups_id" {}
variable "vpc_id" {}
variable "target" {
    type = map(any)
    
    default = {
        name             = "tg"
        port             = "443"
        protocol         = "HTTPS"
        timeout          = 5
        interval         = 3
        healthy_threshold = 3
        matcher          = 200
        type             = "forward"
    }
}

variable "path" {
    type = map(any)

    default = {
        healthcheckpath = "/healthstatus"
    }
}