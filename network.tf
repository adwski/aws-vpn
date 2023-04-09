# VPC
resource "aws_vpc" "vpn_vpc" {
  cidr_block = "${var.vpc_cidr_block}"
}

# Gateway for internet access
resource "aws_internet_gateway" "vpn_gw" {
  vpc_id = aws_vpc.vpn_vpc.id
}

# Route table with default route via internet gateway
resource "aws_route_table" "vpn_table" {
  vpc_id = aws_vpc.vpn_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpn_gw.id
  }
}

# Make this route table main
resource "aws_main_route_table_association" "vpn" {
  vpc_id         = aws_vpc.vpn_vpc.id
  route_table_id = aws_route_table.vpn_table.id
}

# VPN subnet in zone a
resource "aws_subnet" "vpn_subnet_a" {
  vpc_id            = aws_vpc.vpn_vpc.id
  cidr_block        = "${var.vpn_subnet}"
  availability_zone = "${var.region}a"
}
