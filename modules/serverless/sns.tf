resource "aws_sns_topic" "main" {
    count          = length(var.sns_topic_name)
    name           = element(var.sns_topic_name, count.index)
    display_name   = element(var.sns_topic_name, count.index)

    tags = {
      "Name" = "devops-engineer",
      "Automated" = "yes"
    }
}

resource "aws_sns_topic_subscription" "main" {
    count                   = length(var.sns_topic_name)
    topic_arn               = aws_sns_topic.main[count.index % length(var.sns_topic_name)].arn
    protocol                = "sms"
    endpoint_auto_confirms  = true
    endpoint                = var.endpoint
  
}

