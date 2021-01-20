resource "aws_wafregional_ipset" "adroit_ipset" {
    name = "WHITELIST"
    ip_set_descriptor {
        type = "IPV4"
        value = var.ingress_trusted_ip_whitelist
    }
    
}

# create WAF rule to block IPs that are not in the whitelist ipset, based on a rate 
# limit of 2000 requests over a 5mins period

resource "aws_wafregional_rule" "adroit_waf_rule" {
    depends_on = [aws_wafregional_ipset.adroit_ipset]
    name       = "inwhitelist"
    metric_name = "inwhitelist"

    rate_key    = "IP"
    rate_limit  = 2000 #max number of requests allowed in a 5 mins period

    predicate {
      data_id   = aws_wafregional_ipset.adroit_ipset.id
      negated   = true
      type      = "IPMATCH"
    }
    
}