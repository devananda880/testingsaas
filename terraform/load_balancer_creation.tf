resource "aws_lb" "sample_lb" {
    #for_each           = var.alb_names
    #name               = each.value
    name                = var.load_balancer_name
    internal           = false
    load_balancer_type = "application" 
    security_groups    = ["${aws_security_group.public.id}"]
    subnets            = ["${aws_subnet.terraform-subnet_1.id}","${aws_subnet.terraform-subnet_2.id}"]
    enable_cross_zone_load_balancing = "true"
    tags = {
         Environment = "Production"
         Role        = "Sample-Application"
    }
}