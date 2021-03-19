profile   = "devops-engineer"
region    = "eu-west-1"
ami       = "ami-0fb8881276a9bc6e8"
key_name  = "devops-key"

# VPC Networking range
vpc_cidr = "10.0.0.0/16"

#availability_zones = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]

project_networks = {
    zones = [
        "eu-west-1a",
        "eu-west-1b",
    ]
    public_subnets = [
        "10.0.1.0/24",
        "10.0.3.0/24",

    ]
    private_subnets = [
        "10.0.2.0/24",
        "10.0.4.0/24",
    ]
    public_subnet_names = [
        "management-1",
        "management-2",
    ]
    private_subnet_names = [
        "app-1",
        "app-2",
    ]
}

# cloudfront components
cld-region = "us-east-1"
environment = "prod"
goaldomain = "*.onaivstone.co.uk"
site-index = "sitemaintenance.html"