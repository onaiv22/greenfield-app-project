resource "aws_route53_record" "cdn-cname" {
    zone_id = "Z066309624KG8B8Z7BXIN"
    name = "web.onaivstone.co.uk"
    type = "A"

    alias {
        name = aws_cloudfront_distribution.web.domain_name
        zone_id = "Z2FDTNDATAQYW2"
        evaluate_target_health = false
    }
}


