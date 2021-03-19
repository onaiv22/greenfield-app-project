resource "aws_cloudfront_distribution" "web" {
    origin {
        domain_name                = aws_s3_bucket.static_website.bucket_regional_domain_name
        origin_id                  = "origin-bucket-${aws_s3_bucket.static_website.id}"
        origin_path                = "/templates"

        s3_origin_config {
            origin_access_identity = aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path
        }
    }
    enabled                        = true 
    is_ipv6_enabled                = true 
    comment                        = "cloudfront distribution for maintenance page"
    default_root_object            = var.site-index

    logging_config {
        bucket                     = aws_s3_bucket.cld-static_web_access_logs.bucket_domain_name
        prefix                     = "cld-log/"
    }

    #aliases = [aws_route53_record.cdn-cname.fqdn]

    default_cache_behavior {
        allowed_methods           = ["GET", "HEAD"]
        cached_methods            = ["GET", "HEAD"]
        target_origin_id          = "origin-bucket-${aws_s3_bucket.static_website.id}"

        forwarded_values {
            query_string          = false

            cookies {
                forward           = "none"
            }
        }

        viewer_protocol_policy    = "redirect-to-https"
        compress                  = true
        min_ttl                   = var.min_ttl
        default_ttl               = var.default_ttl
        max_ttl                   = var.max_ttl
    }

    price_class                   = "PriceClass_200"
    
    restrictions {
        geo_restriction {
            restriction_type      = "none"
        }
    }

    tags = {
        Env = "prod"
    }
    viewer_certificate {
        acm_certificate_arn       = var.certificate_arn
        ssl_support_method        = "sni-only"
        #minimum_protocol_version = "TLSv1"
    }

    custom_error_response {
        error_caching_min_ttl = "0"
        error_code            = "403"
        response_code         = "503"
        response_page_path    = "/templates/sitemaintenance.html"
    }

    custom_error_response {
        error_caching_min_ttl = "0"
        error_code            = "503"
        response_code         = "503"
        response_page_path    = "/templates/sitemaintenance.html"
    }

    custom_error_response {
        error_caching_min_ttl = "0"
        error_code            = "404"
        response_code         = "503"
        response_page_path    = "/templates/sitemaintenance.html"
    }

    
}