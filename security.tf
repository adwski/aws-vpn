resource "aws_security_group" "vpn_rules" {
  name        = "vpn_rules"
  description = "Allow VPN comms"
  vpc_id      = aws_vpc.vpn_vpc.id
}

resource "aws_vpc_security_group_egress_rule" "allow_all" {
  security_group_id = aws_security_group.vpn_rules.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.vpn_rules.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}


resource "aws_vpc_security_group_ingress_rule" "allow_udp" {
  for_each = var.udp_ports

  security_group_id = aws_security_group.vpn_rules.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = "${each.value}"
  ip_protocol = "udp"
  to_port     = "${each.value}"
}

resource "aws_vpc_security_group_ingress_rule" "allow_tcp" {
  for_each = var.tcp_ports

  security_group_id = aws_security_group.vpn_rules.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = "${each.value}"
  ip_protocol = "tcp"
  to_port     = "${each.value}"
}
