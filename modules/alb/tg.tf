resource "aws_lb_target_group" "main" {
    name      = var.name
    port      = lookup(var.target, "port", "443")
    protocol  = lookup(var.target, "protocol", "HTTPS")
    vpc_id    = var.vpc_id
    target_type = "instance"

    health_check {
      enabled               = true
    #   interval             = lookup(var.target, "interval", 5)
      path                 = "/healthstatus"
      port                 = "traffic-port"
      protocol             = lookup(var.target, "protocol", "HTTPS")
      timeout              = lookup(var.target, "timeout", 5)
      healthy_threshold     = lookup(var.target, "healthy_threshold", 3)
      matcher              = lookup(var.target, "matcher", 200)
    }
}

resource "aws_lb_listener" "main" {
    load_balancer_arn      = aws_lb.main.arn 
    port                   = lookup(var.target, "port", "443")
    protocol               = lookup(var.target, "protocol", "HTTPS")
    certificate_arn        = aws_acm_certificate.main.arn
    ssl_policy             = "ELBSecurityPolicy-2016-08"

    default_action {
        type               = "forward"
        target_group_arn   = aws_lb_target_group.main.arn
    }
}

resource "aws_acm_certificate" "main" {
    domain_name            = "onaivstone.tk"
    validation_method      = "DNS"
}