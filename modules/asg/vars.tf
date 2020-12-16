variable "key_name" {}
variable "vpc_id" {} 
variable "ami" {}
variable "name" {}
variable "security_group_id" {}
variable "user_data" {}
variable "description" {}    
variable "launch_template" {}
variable "public_subnet_ids" {}
variable "target" {
    type = map(any)

    default = {
        name             = "alb"
        min_size         = 2
        max_size         = 2
        desired_capacity = 2
        description      = "default asg configuration"
        health_check_type = "EC2"
        health_check_grace_period = "300"
    }
}


# output bastion-sg_id {
#     value = aws_security_group.bastion-sg.id
# }

# output alb_id {
#     value = aws_security_group.alb.id
# }

# output nginx_id {
#     value = aws_security_group.nginx.id
# }

output launch_template_id {
    value = aws_launch_template.main.id
}