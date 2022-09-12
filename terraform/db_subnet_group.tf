resource "aws_db_subnet_group" "default" {
  name       = var.db_subnetgroupname
  subnet_ids = ["${aws_subnet.terraform-subnet_1.id}", "${aws_subnet.terraform-subnet_2.id}"]

  tags = {
    Name = "My DB subnet group"
  }
}
