variable "site-index" {
   type = string
   description = "website index page"
   default = "sitemaintenance.html"
     
}

variable "certificate_arn" {}


#  variable "acm" {}

# variable "domain_name" {
#     type = string
#     description = "The domain which CFD requires for cname creation"
  
# }

variable "min_ttl" {
    type = string 
    default = "0"
}

variable "default_ttl" {
    type = string 
    default = "3600"
}
variable "max_ttl" {
    type = string 
    default = "86400"
}