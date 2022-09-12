resource "aws_route53_record" "dom" {
  zone_id = "Z3H9K4B2UE4C37"
  name    = var.DNS_name
  type    =  "CNAME"
  ttl     = 60
  records = [aws_lb.sample_lb.dns_name]
  #"A"
  ###ttl     = "300"
  #records = "${aws_instance.this.*.public_ip}"
  
  #alias {
  #  name                   = "${aws_lb.sample_lb.dns_name}"
  #  zone_id                = aws_lb.sample_lb.zone_id
  #  evaluate_target_health = true
  #}
  
}