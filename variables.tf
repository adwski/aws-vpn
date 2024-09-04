variable "region" {}

variable "vpc_cidr_block" {}

variable "vpn_subnet" {}
variable "vpn_instance_ip" {}
variable "vpn_instance_name" {}
variable "vpn_instance_ami" {}
variable "vpn_instance_type" {}

variable "public_key" {}

variable "udp_ports" {
    type = set(string)
    default = []
}
variable "tcp_ports" {
    type = set(string)
    default = []
}
