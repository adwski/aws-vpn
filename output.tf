output "instance_ip_addr" {
  value = aws_eip.vpn.public_ip
}
