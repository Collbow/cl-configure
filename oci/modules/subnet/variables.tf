# Copyright © 2020-2021 Collbow All Rights Reserved

variable "compartment_ocid" {}
variable "management_label" {
  default = ""
}
variable "availability_domain" {}
variable "vcn_id" {}
variable "route_table_id" {
  default = ""
}
variable "security_list_ids" {
  default = []
}
variable "cidr_block" {
}
