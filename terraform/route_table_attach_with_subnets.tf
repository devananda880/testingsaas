# Route table association with public subnets
resource "aws_route_table_association" "a" {
  #count = length(var.subnets_cidr)
  subnet_id      = "${aws_subnet.terraform-subnet_1.id}"
  route_table_id = "rtb-0a5023b60c8260264"
  #aws_route_table.public_rt.id
}
resource "aws_route_table_association" "a1" {
  #count = length(var.subnets_cidr)
  subnet_id      = "${aws_subnet.terraform-subnet_2.id}"
  route_table_id = "rtb-0a5023b60c8260264"
  #aws_route_table.public_rt.id
}