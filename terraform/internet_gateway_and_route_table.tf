## Internet Gateway
#resource "aws_internet_gateway" "terra_igw" {
#  vpc_id = "vpc-0f76f954b13dab293"
#  tags = {
#    Name = var.internet_gateway
#  }
#}

## Route table: attach Internet Gateway 
#resource "aws_route_table" "public_rt" {
#  vpc_id = "vpc-0f76f954b13dab293"
#  route {
#    cidr_block = "0.0.0.0/0"
#    gateway_id = aws_internet_gateway.terra_igw.id
#  }
#  tags = {
#    Name = var.route_table
#  }
#}