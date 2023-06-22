resource "aws_acm_certificate" "cert" {
    domain_name = "*.senistone.co.uk" 
    validation_method = "DNS"
    subject_alternative_names = ["web.senistone.co.uk"]

    lifecycle {
        create_before_destroy = true
    }
}

data "aws_route53_zone" "public" {
    name         = "senistone.co.uk"
    private_zone = false
}

resource "aws_route53_record" "cldfront_aliase" {
    for_each = {
        for x in aws_acm_certificate.cert.domain_validation_options : x.domain_name => {
            name = x.resource_record_name
            record = x.resource_record_value
            type = x.resource_record_type
            zone_id = x.domain_name == "senistone.co.uk" ? data.aws_route53_zone.public.zone_id : data.aws_route53_zone.public.zone_id
        }
    }
    allow_overwrite = true 
    name = each.value.name
    records = [each.value.record]
    ttl = 60
    type = each.value.type
    zone_id = "Z05942591BBZANTS6XK8U"
}

resource "aws_acm_certificate_validation" "cert-validation" {
     certificate_arn  = aws_acm_certificate.cert.arn
     validation_record_fqdns = [for record in aws_route53_record.cldfront_aliase : record.fqdn]
 }

data "aws_acm_certificate" "cert_issued" {
    domain = "*.senistone.co.uk"
    statuses  = ["ISSUED"]
    types      = ["AMAZON_ISSUED"]
    most_recent = true

}

output "cert_issued" {
    value = data.aws_acm_certificate.cert_issued.arn
}


output "cert" {
    value = aws_acm_certificate.cert.arn
}




