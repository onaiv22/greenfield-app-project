resource "aws_wafregional_web_acl" "adroit_wafacl" {
    name            = "WebACL"
    metric_name     = "WebACL"
    logging_configuration {
      log_destination = aws_kinesis_firehose_delivery_stream.waf_logs_stream.arn
    }

    default_action {
        type = "ALLOW"
    }

    rule {
        action {
            type = "BLOCK"
        }

        priority = 1
        rule_id  = aws_wafregional_rule.adroit_waf_rule.id
    }

    rule {
      action {
          type = "BLOCK"
      }

      priority = 2
      rule_id = aws_wafregional_rule.sql_waf_rule.id
    }
    rule {
      action {
          type = "COUNT"
      }

      priority = 3
      rule_id = aws_wafregional_rule.adroit_largebodyrule.id
    }
    
    rule {
      action {
          type = "BLOCK"
      }

      priority = 4
      rule_id = aws_wafregional_rule.adroit_xss_waf_rule.id
    }
}

output "web_acl_id" {
    value = aws_wafregional_web_acl.adroit_wafacl.id
  
}