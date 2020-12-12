resource "aws_security_group" "bastion-sg" {
    name = "bastion-sg"
    description = "allow inbound and outbound traffic"
    vpc_id = var.vpc_id

    #Allow ssh from from enigineers in brixton and thornton heath in to bastion.

    dynamic "ingress" {
        for_each = local.ingress_rules
        
        content {
            description = ingress.value.description
            from_port   = ingress.value.port
            to_port     = ingress.value.port
            protocol    = "tcp" 
            cidr_blocks = ingress.value.cidr_blocks
        }
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
  }
}
locals {
    ingress_rules = [{
        port = "22"
        description = "allow traffic from devop-engineers brixton"
        cidr_blocks = ["80.5.79.169/32"]
    },
    {
        port = 22
        description = "allow traffic from vpc network"
        cidr_blocks = ["10.0.0.0/16"]
    }]
}