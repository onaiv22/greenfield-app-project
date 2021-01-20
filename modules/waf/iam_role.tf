# https://docs.aws.amazon.com/waf/latest/developerguide/logging.html
# https://docs.aws.amazon.com/firehose/latest/dev/controlling-access.html#using-iam-s3
data "aws_iam_policy_document" "waf_logs_s3_policy" {
    statement {
      sid = "Allows3"

      actions = [
          "s3:AbortMultipartUpload",
          "s3:GetBucketLocation",
          "s3:GetObject",
          "s3:ListBucket",
          "s3:ListBucketMultipartUploads",
          "s3:PutObject"
          
      ]

      resources = [ 
          aws_s3_bucket.waf_logs.arn,
          "${aws_s3_bucket.waf_logs.arn}/*" 
      ]
    }
    statement {
        sid = "cloudwatch"

        actions = [
            "logs:PutlogEvents" 
        ]

        resources = [ 
            aws_cloudwatch_log_stream.waf_logs.arn
         ]
      
    }
}

data "aws_iam_policy_document" "waf_logs_assume_role" {
    statement {
        actions = ["sts:AssumeRole",]

        principals {
            type    = "Service"
            identifiers = ["firehose.amazonaws.com"]
        }
    }
}

###################################################################################
# create iam role with assume role policy
###################################################################################

resource "aws_iam_role" "waf_logs_firehose_role" {
    name               = "adroit-waf-logs"
    assume_role_policy = data.aws_iam_policy_document.waf_logs_assume_role.json
    path               = "/"
    force_detach_policies = true
}

###################################################################################
# create kinesis role policy with permissions to s3 buckets
###################################################################################

resource "aws_iam_policy" "waf_logs_firehose_policy" {
    name                = "AWSKinesisS3Policy"
    path                = "/"
    policy              = data.aws_iam_policy_document.waf_logs_s3_policy.json
}

###################################################################################
# attarch iam role to policy
###################################################################################

resource "aws_iam_policy_attachment" "role-policy-attachment" {
    name                 = "policy-attachment"
    roles                = [aws_iam_role.waf_logs_firehose_role.id]
    policy_arn           = aws_iam_policy.waf_logs_firehose_policy.arn
}