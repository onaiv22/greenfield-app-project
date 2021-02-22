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
    gw_id      = module.vpc.gw_id 
}
    
module "bastion-asg" {
    source            = "./modules/asg" 
    ami               = var.ami
    name              = "bastion-asg"
    vpc_id            = module.vpc.vpc_id
    key_name          = var.key_name
    user_data         = filebase64("bootstrap.sh")
    security_group_id = module.subnets.bastion-sg_id
    launch_template   = module.bastion-asg.launch_template_id
    public_subnet_ids = module.subnets.public_subnet_id
    description       = "launch template for bastion instances"
}

module "nginx-asg" {
    source            = "./modules/asg"
    ami               = var.ami 
    name              = "nginx-asg"
    vpc_id            = module.vpc.vpc_id  
    key_name          = var.key_name
    user_data         = filebase64("bootstrap-nginx.sh")
    security_group_id = module.subnets.nginx_id
    launch_template   = module.nginx-asg.launch_template_id
    public_subnet_ids = module.subnets.public_subnet_id
    description       = "launch template for nginx instances"
}

module "nginx-alb" {
    source             = "./modules/alb"
    name               = "nginx-alb"
    security_groups_id = module.subnets.alb_id
    subnets            = module.subnets.public_subnet_id
    vpc_id            = module.vpc.vpc_id  
}

 module "s3-source" {
     source         = "./modules/serverless"
     sns            = module.s3-source.arn
     
 }

module "waf" {
    source = "./modules/waf"

}

module "k8s" {
    source = "./modules/k8s-setup"

}
# module "s3-processed" {
#     source = "./modules/serverless"
#     acl    = "private"
#     access-log-name = "private-bucket-access-logs"
# }