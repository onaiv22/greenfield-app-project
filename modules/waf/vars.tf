variable "webacl_name" {
  type        = string
  default     = "WebACL"
  description = "Name of the Web ACL firewall"
}

variable "webacl_description" {
  type        = string
  default     = "WebACL"
  description = "Description for the Web ACL"
}

variable "scope" {
  type        = string
  default     = "REGIONAL"
  description = <<-EOD
  Whether for CloudFront distribution or for a regional application.
  Valid values are CLOUDFRONT or REGIONAL.
  To work with CloudFront, you must also specify the region us-east-1 on the AWS provider.
  EOD
}

variable "waf_rule_list" {
  default = [
    {"name" : "AWSManagedRulesCommonRuleSet", "rule_name": "AWS-AWSManagedRulesCommonRuleSet", "priority": "0"},
    {"name" : "AWSManagedRulesAmazonIpReputationList", "rule_name": "AWS-AWSManagedRulesAmazonIpReputationList", "priority" : "1"},
    {"name" : "AWSManagedRulesSQLiRuleSet", "rule_name" : "AWS-AWSManagedRulesSQLiRuleSet" , "priority" : "2"}
  ]
}
