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
      actions = ["s3:GetObject"]
      resources = ["${aws_s3_bucket.main[0].arn}/*"]
    }
    statement {
        actions = ["s3:PutObject"]
        resources =["${aws_s3_bucket.main[1].arn}/*"]
    }
    statement {
        actions = [
            "logs:PutLogEvent",
            "logs:CreateLogGroup",
            "logs:CreateLogStream"
            ]
        resources = ["arn:aws:logs:*:*:*"]    
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
    name               = "lambda-s3-role"
    assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
    path               = "/"
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
