resource "aws_cloudwatch_log_group" "waf_logs" {
  name              = "/aws/kinesisfirehose/aws-waf-logs-adroit"
  retention_in_days = "7"

  # Apply default tags, and merge with a map construction of additional tags
  tags = {
      "Name" = "adroit-waf-logs"
      "role" = "waf"
  }
}

resource "aws_cloudwatch_log_stream" "waf_logs" {
  name           = "S3Delivery"
  log_group_name = aws_cloudwatch_log_group.waf_logs.name
}