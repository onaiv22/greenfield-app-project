variable "s3-bucket-names" {
    type = list(string)
    default = ["source-20122020", "destination-20122020-scanned", "av-definitions20122020", "lambda-functions-integration20122020"]

}

variable "sns" {}

variable "sns_topic_name" {
    type = list(string)
    default = ["av-scan-start", "av-status"]
}

variable "function_name" {
    type = list(string)
    default = ["DefinitionUpdataLambda", "AVScannerLambda"]
}
variable "handler" {
    type = list(string)
    default = ["update.lambda_handler", "scan.lambda_handler"]
}

variable "display_name" {
    description = "Name shown in confirmation emails"
    default ="av_status"
}
variable "email_addresses" {
  description = "Email address to send notifications to"
  default = [
    "femi.okuta@bjss.com"
  ]
}

variable "protocol" {
  default     = "email"
  description = "SNS Protocol to use. email or email-json"
}

variable "stack_name" {
  description = "Unique Cloudformation stack name that wraps the SNS topic."
  default     = "snsConfig"
}
locals {
    LambdaSettings = {
        "DefinitionUpdateLambda" = {
            handler       = "update.lambda_handler",
            
                variables = {
                    "AV_DEFINITION_S3_BUCKET" = aws_s3_bucket.main[2].id
                }
            

        },
        "AVScannerLambda" = {
            handler       = "scan.lambda_handler",
            
                variables = {
                    "AV_DEFINITION_S3_BUCKET"    = aws_s3_bucket.main[2].id
                    "AV_SCAN_START_SNS_ARN"      = var.sns
                    "AV_STATUS_SNS_ARN"          = var.sns
                }
        }
    }
}
