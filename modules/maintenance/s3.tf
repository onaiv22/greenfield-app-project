################################################################################################################
## origin access identity
################################################################################################################
resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
    comment = "Cloudfront access to s3 bucket"
}

data "aws_iam_policy_document" "s3_policy" {
    statement {
        actions = ["s3:GetObject"]
        resources = ["${aws_s3_bucket.static_website.arn}/*"]

        principals {
            type = "AWS"
            identifiers = [aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn]
        }
    }
    statement {
        actions = ["s3:ListBucket"]
        resources = [aws_s3_bucket.static_website.arn]

        principals {
            type = "AWS"
            identifiers = [aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn]
        }
    }
}


################################################################################################################
## create s3 bucket for static file
################################################################################################################
resource "aws_s3_bucket" "static_web_access_logs" {
    bucket = "main-te-nan-ce-1-access-logs"
    acl    = "log-delivery-write"
    force_destroy = true
}

resource "aws_s3_bucket" "cld-static_web_access_logs" {
    bucket = "cld-main-te-nan-ce-1-access-logs"
    force_destroy = true
    acl = "private"
}

resource "aws_s3_bucket" "static_website" {
    bucket = "main-te-nan-ce-1"
    acl    = "private"

    website {
        index_document = var.site-index
    }
    versioning {
        enabled = true
    }
    logging {
        target_bucket = aws_s3_bucket.static_web_access_logs.id
        target_prefix = "log/"
    }

    cors_rule {
        allowed_headers = ["*"]
        allowed_methods = ["PUT", "POST", "GET"]
        allowed_origins = ["*"]
        expose_headers = ["ETag"]
        max_age_seconds = 3000
    }
}

resource "aws_s3_bucket_policy" "static_website" {
    bucket = aws_s3_bucket.static_website.id
    policy = data.aws_iam_policy_document.s3_policy.json
    
}
################################################################################################################
## Upload S3 object for the static website
################################################################################################################
resource "aws_s3_bucket_object" "web_object" {
  for_each = fileset(path.module, "templates/*")
  bucket = aws_s3_bucket.static_website.id
  key    = each.value
  source = "${path.module}/${each.value}"
  etag = filemd5("${path.module}/${each.value}")
}

output "origin_access_identity" {
    value = aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path
}

