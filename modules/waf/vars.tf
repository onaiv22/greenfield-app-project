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

variable "vendor_name"{
  type = map 
  default = {
    vendor_name = "AWS"
  }

}

variable "waf_rule_list" {
  type = list
  default = [
    {"rule_name": "AWS-AWSManagedRulesCommonRuleSet", "name" : "AWSManagedRulesCommonRuleSet", "priority": "0"},
    {"rule_name": "AWS-AWSManagedRulesAmazonIpReputationList", "name" : "AWSManagedRulesAmazonIpReputationList", "priority" : "1"},
    {"rule_name": "AWS-AWSManagedRulesKnownBadInputsRuleSet", "name" : "AWSManagedRulesKnownBadInputsRuleSet", "priority" : "2"},
    {"rule_name": "AWS-AWSManagedRulesSQLiRuleSet", "name": "AWSManagedRulesSQLiRuleSet", "priority" : "3"}
  ]
}
