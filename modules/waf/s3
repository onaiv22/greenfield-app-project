#####################################################
#s3 bucket for waf logs from kinesis firehose stream 
###################################################
resource "aws_s3_bucket" "waf_logs" {
    bucket = "adroit-waf-logs"
    acl    = "private"
    #region = var.region

    server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "aws:kms"
      }
    }
  }

  tags = {
    "Name" = "Adroit-logs"
  }
}

# BLOCK PUBLIC ACCESS TO S3 BUCKET
resource "aws_s3_bucket_public_access_block" "no_public_source" {
  bucket = aws_s3_bucket.waf_logs.id

  block_public_acls       = "true"
  block_public_policy     = "true"
  ignore_public_acls      = "true"
  restrict_public_buckets = "true"
}

# Create policy for WAF log bucket
#############################################################################
#By default, Amazon S3 allows both HTTP and HTTPS requests. 
#To comply with the s3-bucket-ssl-requests-only rule, 
#confirm that your bucket policies explicitly deny access to HTTP requests. 
#Bucket policies that allow HTTPS requests without explicitly denying HTTP 
#requests might not comply with the rule.
#to ensure bucket policies require encryption during data transit
###########################################################################
data "aws_iam_policy_document" "waf_bucket" {
  statement {
    sid     = "Enforce HTTPS Connections"
    effect  = "Deny"
    actions = ["s3:*"]

    principals {
      identifiers = ["*"]
      type        = "*"
    }

    resources = ["${aws_s3_bucket.waf_logs.arn}/*"]

    condition {
      test     = "Bool"
      values   = ["false"]
      variable = "aws:SecureTransport"
    }
  }

  statement {
    sid     = "Restrict Delete* Actions"
    actions = ["s3:Delete*"]
    effect  = "Deny"

    principals {
      identifiers = ["*"]
      type        = "*"
    }

    resources = ["${aws_s3_bucket.waf_logs.arn}/*"]
  }
}

# Add policy to bucket
resource "aws_s3_bucket_policy" "waf_logging" {
  bucket   = aws_s3_bucket.waf_logs.id
  policy   = data.aws_iam_policy_document.waf_bucket.json
}