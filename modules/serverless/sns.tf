# resource "aws_sns_topic" "main" {
#     count          = length(var.sns_topic_name)
#     name           = element(var.sns_topic_name, count.index)
#     display_name   = element(var.sns_topic_name, count.index)

#     tags = {
#       "Name" = "devops-engineer",
#       "Automated" = "yes"
#     }
# }

# resource "aws_sns_topic_subscription" "main" {
#     count                   = length(var.sns_topic_name)
#     topic_arn               = aws_sns_topic.main[count.index % length(var.sns_topic_name)].arn
#     protocol                = "sms"
#     endpoint_auto_confirms  = true
#     endpoint                = var.endpoint
  
# }

data "template_file" "cloudformation_sns_stack" {
  template = file("${path.module}/templates/email-sns-stack.json.tpl")
  vars = {
    display_name  = var.display_name
    subscriptions = join(",", formatlist("{ \"Endpoint\": \"%s\", \"Protocol\": \"%s\"  }", var.email_addresses, var.protocol))
  }
}

resource "aws_cloudformation_stack" "sns_topic" {
  name          = var.stack_name
  template_body = data.template_file.cloudformation_sns_stack.rendered
  tags = merge(
    map("Name", var.stack_name)
  )
}