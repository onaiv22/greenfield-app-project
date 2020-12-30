resource "aws_lambda_function" "main" {
    for_each          = local.LambdaSettings
    function_name     = each.key
    handler           = each.value.handler
    s3_bucket         = aws_s3_bucket.main[3].id
    s3_key            = aws_s3_bucket_object.object.key
    role              = aws_iam_role.lambda_role.arn 
    runtime           = "python2.7"
    memory_size       = "2048"
    timeout           = "600"
    environment {
        variables = each.value.variables
    }
}

