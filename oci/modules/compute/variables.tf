# Copyright © 2020-2021 Collbow All Rights Reserved

variable "compartment_ocid" {}
variable "management_label" {
  default = ""
}
variable "availability_domain" {}
variable "shape" {
  default = "VM.Standard.E2.1.Micro"
}
variable "operating_system" {
  default = "Canonical Ubuntu"
}
variable "operating_system_version" {
  default = "20.04"
}
variable "boot_volume_size_in_gbs" {
  default = 50
}
variable "subnet_id" {}
variable "assign_public_ip" {
  default = true
}
variable "private_ip" {
  default = ""
}
variable "ssh_public_key" {}
