resource "aws_autoscaling_group" "main" {
    name                        = var.name
    vpc_zone_identifier         = var.public_subnet_ids
    force_delete                = false 
    health_check_type           = lookup(var.target, "health_check_type", "EC2")
    max_size                    = lookup(var.target, "max_size", 2)
    min_size                    = lookup(var.target, "min_size", 2)
    desired_capacity            = lookup(var.target, "desired_capacity", 2)
    health_check_grace_period   = lookup(var.target, "health_check_grace_period", 300)

    launch_template {
        id                 = var.launch_template 
        version            = "$Latest"
    }
}