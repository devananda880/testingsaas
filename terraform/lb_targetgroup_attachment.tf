resource "aws_lb_target_group_attachment" "tg_attachment_test" {
    target_group_arn = aws_lb_target_group.sample_tg.arn
    target_id        = "${element(aws_instance.this.*.id, 0)}"
	#"aws_instance.this.*.id"
	###"${element(split(",", join(",", aws_instance.this.*.id)), count.index)}"
    port             = 8080
}