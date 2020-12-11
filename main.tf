provider "aws" {
    region = var.region
    profile = var.profile
    #version = "2.60"
}

# create networking vpc
module "network" {
    source     = "./modules/networking"
    vpc_cidr = var.vpc_cidr
    
}
    
