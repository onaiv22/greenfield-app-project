resource "aws_security_group" "bastion-sg" {
    name = "bastion-sg"
    description = "allow inbound and outbound traffic"
    vpc_id = var.vpc_id

    #Allow ssh from from enigineers in brixton and thornton heath in to bastion.

    dynamic "ingress" {
        for_each = local.ingress_rules1_bastion
        
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

resource "aws_security_group" "alb" {
    name = "alb-sg"
    description = "allow inbound and outbound traffic to and from alb"
    vpc_id = var.vpc_id

    #Allow incoming traffic from the world

    dynamic "ingress" {
        for_each = local.ingress_rules2_alb
        
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

resource "aws_security_group" "nginx" {
    name = "nginx-sg"
    description = "allow inbound and outbound traffic to and from alb"
    vpc_id = var.vpc_id

    #Allow incoming traffic from alb

    dynamic "ingress" {
        for_each = local.ingress_rules3_nginx
        
        content {
            description = ingress.value.description
            from_port   = ingress.value.port
            to_port     = ingress.value.port
            protocol    = "tcp" 
            security_groups = ingress.value.security_groups
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
    ingress_rules1_bastion = [{
        port = "22"
        description = "allow traffic from devop-engineers brixton"
        cidr_blocks = ["80.5.79.0/24"]
    },
    {
        port = "22"
        description = "allow traffic from thornton heath"
        cidr_blocks = ["80.195.205.0/24"]
    },
    {
        port = "22"
        description = "allow traffic from vpc network"
        cidr_blocks = ["10.0.0.0/16"]
    }]
    ingress_rules2_alb = [{
        port = 443
        description = "allow public traffic to alb"
        cidr_blocks = ["0.0.0.0/0"]

    }]
    ingress_rules3_nginx = [{
        port = 443
        description = "allow traffic from alb"
        security_groups = [aws_security_group.alb.id]
    },
    {
        port = 22
        description = "allow traffic from bastion_servers"
        security_groups = [aws_security_group.bastion-sg.id]
    }]
}