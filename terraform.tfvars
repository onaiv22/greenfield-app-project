profile = "devops-engineer"
region = "eu-west-1"

# VPC Networking range
vpc_cidr = "10.0.0.0/16"

project_networks = {
    zones = [
        "eu-west-1a",
        "eu-west-1b",
    ]
    public_subnets = [
        "10.0.1.0/24",

    ]
    private_subnets = [
        "10.0.3.0/26",
    ]
}