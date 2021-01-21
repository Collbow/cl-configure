# Copyright © 2020-2021 Collbow All Rights Reserved

variable "compartment_ocid" {}
variable "management_label" {
  default = ""
}
variable "shape" {
  default = "flexible"
}
variable "maximum_bandwidth_in_mbps" {
  default = 10
}
variable "minimum_bandwidth_in_mbps" {
  default = 10
}
variable "subnet_ids" {
  type = list(string)
}
variable "policy" {
  default = "ROUND_ROBIN"
}
variable "health_checker_response_body_regex" {
  default = ".*"
}
variable "health_checker_url_path" {
  default = "/"
}
variable "backend_server" {
  type = list(object({
    ip_address = string
    port       = number
    }
  ))
}
variable "certificate_name" {}
variable "ca_certificate" {}
variable "private_key" {}
variable "passphrase" {
  default = ""
}
variable "public_certificate" {}
variable "verify_peer_certificate" {
  default = false
}

