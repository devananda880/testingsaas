resource "aws_subnet" "terraform-subnet_1" {
  vpc_id            = "vpc-0f76f954b13dab293"
  cidr_block        = var.subnet1_cidr_block
  availability_zone = "us-east-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = var.subnet1_name
  }
}

resource "aws_subnet" "terraform-subnet_2" {
  vpc_id            = "vpc-0f76f954b13dab293"
  cidr_block        = var.subnet2_cidr_block
  availability_zone = "us-east-2b"
  map_public_ip_on_launch = true

  tags = {
    Name = var.subnet2_name
  }
}