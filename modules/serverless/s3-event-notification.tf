resource "aws_s3_bucket_notification" "event_notification" {
    bucket = aws_s3_bucket.main[0].id 

    lambda_function {
        lambda_function_arn = aws_lambda_function.main["AVScannerLambda"].arn 
        events              = ["s3:ObjectCreated:*"]
        #filter_prefix       = "AWSLogs/"
        #filter_suffix       = ".log"
    }

    depends_on              = [aws_lambda_permission.allow_s3]
}

# questions to ask
# are we allowing any extensions for files if yes then apply the suffix 
# for event notification only for those file extensions 
# if not leave it out.

resource "aws_cloudwatch_event_rule" "main" {
    name                = "update-AV-definition"
    description         = "trigger AV-definition update"
    schedule_expression = "rate(3 hours)"
    is_enabled          = true
    tags = {
      "Automated" = "Yes"
    }
}

resource "aws_cloudwatch_event_target" "main" {
    rule = aws_cloudwatch_event_rule.main.id
    arn  = aws_lambda_function.main["DefinitionUpdateLambda"].arn

}
