provider "aws" {
    region = var.region
    profile = var.profile
    #version = "2.60"
}

# create networking vpc
module "vpc" {
    source     = "./modules/vpc"
    vpc_cidr = var.vpc_cidr
    
}

module "subnets" {
    source     = "./modules/networking"
    networks   = var.project_networks
    vpc_id     = module.vpc.vpc_id 
}
    
