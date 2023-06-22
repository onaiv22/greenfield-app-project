resource "aws_launch_template" "main" {
    name                                 = var.name 
    image_id                             = var.ami
    instance_type                        = "t2.micro"
    key_name                             = var.key_name
    instance_initiated_shutdown_behavior = "terminate"
    user_data                            = var.user_data
    vpc_security_group_ids               = [var.security_group_id]
    description                          = var.description 
    update_default_version               = true
    tags = {
        Name = "DevEnvironment"

    }
    
}