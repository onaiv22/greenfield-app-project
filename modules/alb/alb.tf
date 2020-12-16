resource "aws_lb" "main" {
    name               = var.name
    load_balancer_type = "application"
    subnets            = var.subnets
    security_groups    = [var.security_groups_id]

    enable_deletion_protection = false 

    //access_logs {
      //  bucket = 
        //enabled = "true"
    //}
}
