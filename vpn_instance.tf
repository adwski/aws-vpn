resource "aws_instance" "vpn" {
  ami           = "${var.vpn_instance_ami}"
  instance_type = "${var.vpn_instance_type}"

  network_interface {
    network_interface_id = aws_network_interface.vpn.id
    device_index         = 0
  }

  root_block_device {
    delete_on_termination = true
    volume_type           = "standard"
    volume_size           = 10
  }

  key_name = aws_key_pair.deployer.key_name

  provisioner "remote-exec" {
    inline = ["sudo hostnamectl set-hostname ${var.vpn_instance_name}"]
  }

  # this connection requires that you have ssh key loaded in ssh-agent
  connection {
    type     = "ssh"
    user     = "ubuntu"
    host     = self.public_ip
  }
}

# Instance network interface
resource "aws_network_interface" "vpn" {
  subnet_id         = aws_subnet.vpn_subnet_a.id
  private_ips       = ["${var.vpn_instance_ip}"]
  security_groups   = [aws_security_group.vpn_rules.id]
  source_dest_check = false
}

# Public IP
resource "aws_eip" "vpn" {
  vpc                       = true
  network_interface         = aws_network_interface.vpn.id
  associate_with_private_ip = "${var.vpn_instance_ip}"
}
