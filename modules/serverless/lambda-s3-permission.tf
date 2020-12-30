###################################################################################
# give s3 permission to call lambda
###################################################################################
resource "aws_lambda_permission" "allow_s3" {
    #count          = length(var.function_name)
    statement_id   = "s3InvokeLambda"
    action         = "lambda:InvokeFunction"
    function_name  = aws_lambda_function.main["AVScannerLambda"].function_name
    principal      = "s3.amazonaws.com"
    source_arn     = aws_s3_bucket.main[0].arn
    
}
resource "aws_lambda_permission" "allow_cloudwatch" {
    #count          = length(var.function_name)
    statement_id   = "cloudwatchInvokeLambda"
    action         = "lambda:InvokeFunction"
    function_name  = aws_lambda_function.main["DefinitionUpdateLambda"].function_name
    principal      = "events.amazonaws.com"
    source_arn     = aws_cloudwatch_event_rule.main.arn

}