resource "aws_wafv2_web_acl" "main" {
    name        = "webacl"
    description = "webacl_description"
    scope       = "REGIONAL"

    default_action {
        block {}
    }
    
    tags = {
      Tag1 = "Value1"
    }

    dynamic "rule" {
      for_each = var.waf_rule_list

      content {
        name = rule.value["rule_name"]
        priority = rule.value["priority"]

        override_action {
          count {}
        }
        statement {
          managed_rule_group_statement {
            name = rule.value["name"]
            vendor_name = "AWS"
          }
        }
        visibility_config {
          cloudwatch_metrics_enabled = true 
          metric_name                = "${rule.value["name"]}-metric"
          sampled_requests_enabled   = true
        }
      }
    }  
    visibility_config {
      metric_name = "waf-main-metrics"
      cloudwatch_metrics_enabled = true 
      sampled_requests_enabled = true
    }
  }
