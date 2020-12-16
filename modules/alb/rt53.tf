# resource "aws_route53_record" "main" {
#     zone_id = "Z06824323UXD13ZQRLU3S"
#     name    = "nginx-1.onaivstone.tk"
#     type = "A"
#     ttl = "300"
    
# }
resource "aws_route53_record" "www" {
    zone_id = "Z06824323UXD13ZQRLU3S"
    name    = "www.onaivstone.tk"
    type = "CNAME"
    
    alias {
        name = aws_lb.main.dns_name
        zone_id = aws_lb.main.zone_id
        evaluate_target_health = false
    }
}