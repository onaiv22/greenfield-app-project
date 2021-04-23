resource "aws_wafv2_web_acl" "main" {
    name        = var.webacl_name
    description = var.webacl_description
    scope       = var.scope

    default_action {
        allow {}
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
            vendor_name = lookup(var.vendor_name, "vendor_name", "AWS")
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

  output "waf_acl" {
    value = aws_wafv2_web_acl.main.arn

  }
