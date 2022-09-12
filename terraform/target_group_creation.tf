resource "aws_lb_target_group" "sample_tg" {
   #for_each           = var.alb_names
   #name               = each.value
   name                = var.target_group_name
   target_type        = "instance"
   port               = 8080
   protocol           = "HTTP"
   vpc_id             = "vpc-0f76f954b13dab293"
   #"vpc-0f76f954b13dab293"
   health_check {
      healthy_threshold   = var.health_check["healthy_threshold"]
      interval            = var.health_check["interval"]
      unhealthy_threshold = var.health_check["unhealthy_threshold"]
      timeout             = var.health_check["timeout"]
      path                = var.health_check["path"]
      port                = var.health_check["port"]
  }
  
}