variable "s3-bucket-names" {
    type = list(string)
    default = ["uploads20122020", "uploads20122020-scanned", "av-definitions20122020", "lambda-functions-integration20122020"]

}

variable "sns_topic_name" {
    type = list(string)
    default = ["av-scan-start", "av-status"]
}
variable "endpoint" {
    type = string
    default = "+447449620721"
}
variable "function_name" {
    type = list(string)
    default = ["DefinitionUpdataLambda", "AVScannerLambda"]
}
variable "handler" {
    type = list(string)
    default = ["update.lambda_handler", "scan.lambda_handler"]
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
            handler       = "scan.lambder_handler",
            
                variables = {
                    "AV_DEFINITION_S3_BUCKET" = aws_s3_bucket.main[2].id
                    "AV_SCAN_START_SNS_ARN"   = aws_sns_topic.main[0].arn
                    "AV_STATUS_SNS_ARN"       = aws_sns_topic.main[1].arn
                }
        }
    }
}           