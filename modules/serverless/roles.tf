##################################################################################
# create bucket policy for both source $ destination buckets
# source - this will be for unscanned files and destination for scanned files
##################################################################################
data "aws_iam_policy_document" "s3_policy" {
    statement {
      actions = ["s3:ListBucket"]
      resources = [aws_s3_bucket.main[0].arn]
    }
    statement {
      actions = [
          "s3:GetObject",
          "s3:GetObjectTagging"
          ]
      resources = [
          "${aws_s3_bucket.main[0].arn}/*",
          "${aws_s3_bucket.main[2].arn}/*",
          "${aws_s3_bucket.main[3].arn}/*"
          ]
    }
    statement {
        actions = [
            "s3:PutObject",
            "s3:PutObjectTagging",
            "s3:PutObjectVersionTagging"
            ]
        resources =[
            "${aws_s3_bucket.main[1].arn}/*",
            "${aws_s3_bucket.main[2].arn}/*",
            "${aws_s3_bucket.main[3].arn}/*"
            ]
    }
    statement {
        actions = [
            "logs:PutLogEvent",
            "logs:CreateLogGroup",
            "logs:CreateLogStream"
            ]
        resources = ["arn:aws:logs:*:*:*"]    
    }
    statement {
        actions = [
            "sns:Publish"
        ]
        resources = [
            aws_sns_topic.main[0].arn,
            aws_sns_topic.main[1].arn
            
            ]
    }
}
###################################################################################
# create assume role policy for lambda 
###################################################################################

data "aws_iam_policy_document" "lambda_assume_role" {
    statement {
        actions = ["sts:AssumeRole",]

        principals {
            type    = "Service"
            identifiers = ["lambda.amazonaws.com"]
        }
    }
}
###################################################################################
# create iam role with assume role policy
###################################################################################

resource "aws_iam_role" "lambda_role" {
    name               = "bucket-antivirus-update"
    assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
    path               = "/"
    force_detach_policies = true
}
###################################################################################
# create lambda role policy with permissions to s3 buckets
###################################################################################

resource "aws_iam_policy" "lambda_role_policy" {
    name                = "AWSLambdaS3Policy"
    path                = "/"
    policy              = data.aws_iam_policy_document.s3_policy.json
}

###################################################################################
# attarch iam role to policy
###################################################################################

resource "aws_iam_policy_attachment" "role-policy-attachment" {
    name                 = "policy-attachment"
    roles                = [aws_iam_role.lambda_role.id]
    policy_arn           = aws_iam_policy.lambda_role_policy.arn
}

###################################################################################
# output role arn for usage by other resources
###################################################################################

output "lambda_role" {
    value = [aws_iam_role.lambda_role.arn]
}
