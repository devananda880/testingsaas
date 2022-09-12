##cert creation
resource "aws_acm_certificate" "cert" {
  domain_name       = var.DNS_name
  validation_method = "DNS"

  tags = {
    Environment = "saas-test"
  }

  lifecycle {
    create_before_destroy = true
  }
}