resource "aws_wafregional_ipset" "ipset" {
  name = var.WAF_ipset_name

  ip_set_descriptor {
    type  = "IPV4"
    value = var.WAF_ip_address_to_allow_access
  }
}

resource "aws_wafregional_rule" "foo" {
  name        = var.WAF_rule_name
  metric_name = var.WAF_rule_name

  predicate {
    data_id = aws_wafregional_ipset.ipset.id
    negated = false
    type    = "IPMatch"
  }
}

resource "aws_wafregional_web_acl" "foo" {
  name        = var.WAF_web_acl_name
  metric_name = var.WAF_web_acl_name

  default_action {
    type = "BLOCK"
  }

  rule {
    action {
      type = "ALLOW"
    }

    priority = 1
    rule_id  = aws_wafregional_rule.foo.id
  }
}

resource "aws_wafregional_web_acl_association" "foo" {
  resource_arn = aws_lb.sample_lb.id
  web_acl_id   = aws_wafregional_web_acl.foo.id
}