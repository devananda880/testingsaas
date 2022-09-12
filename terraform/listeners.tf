resource "aws_lb_listener" "lb_listener_https" {
   load_balancer_arn    = aws_lb.sample_lb.id
   port                 = "443"
   protocol             = "HTTPS"
   ssl_policy           = "ELBSecurityPolicy-TLS-1-2-2017-01"
   certificate_arn      = aws_acm_certificate.cert.arn
   default_action {
    target_group_arn = aws_lb_target_group.sample_tg.id
    type             = "forward"	
  }
}


resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.sample_lb.id
  port              = "8080"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
	  
      status_code = "HTTP_301"
    }
  }
}