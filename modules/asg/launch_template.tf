resource "aws_launch_template" "main" {
    name                                 = "asg_launch_template"
    image_id                             = var.ami
    instance_type                        = "t2.micro"
    key_name                             = var.key_name
    instance_initiated_shutdown_behavior = "terminate"
    user_data                            = filebase64("bootstrap.sh")
    vpc_security_group_ids               = [aws_security_group.bastion-sg.id]
    description                          = "launch template for bastion server" 
    update_default_version               = true
    network_interfaces {
        associate_public_ip_address = true
    }
}