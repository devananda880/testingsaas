output "public_ip" {
  value = ["${aws_instance.this.*.public_ip}"]
}
output "private_ip" {
  value = ["${aws_instance.this.*.private_ip}"]
}
output "aws_security_gr_id" {
  value = aws_security_group.public.id
}

output "aws_subnet_subnet_1" {
  value = aws_subnet.terraform-subnet_1.id
}

output "DNS_name" {
  value = aws_route53_record.dom.name
}

output "security_group_name" {
  value = aws_security_group.public.name
}

output "subnet_id_1" {
  value = aws_subnet.terraform-subnet_1.id
}

output "subnet_id_2" {
  value = aws_subnet.terraform-subnet_2.id
}

#output "instance_volume_size" {
#  value = ebs_block_device.volume_size
#}

output "DNS_certificate_ARN" {
  value = aws_acm_certificate.cert.arn
}

output "target_group_name" {
  value = aws_lb_target_group.sample_tg.name
}

output "load_balancer_name" {
  value = aws_lb.sample_lb.name
}

output "WAF_ipset_name" {
  value = aws_wafregional_ipset.ipset.name
}

output "WAF_rule_name" {
  value = aws_wafregional_rule.foo.name
}

############################################## RDS ##############

output "password" {
  value = aws_db_instance.default.password
  sensitive = true
}
output "username" {
  value = aws_db_instance.default.username
}
output "rds_endpoint" {
  value = "${aws_db_instance.default.endpoint}"
}

output "secret_manager_name" {
  value = aws_secretsmanager_secret.password.name
}
