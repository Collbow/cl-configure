# Copyright © 2020-2021 Collbow All Rights Reserved

variable "compartment_ocid" {}
variable "management_label" {
  default = ""
}
variable "cpu_core_count" {
  default = 1
}
variable "data_storage_size_in_tbs" {
  default = 1
}
variable "db_version" {
  default = "19c"
}
variable "license_model" {
  default = "LICENSE_INCLUDED"
}
variable "db_workload" {
  default = "OLTP"
}
variable "db_name" {}
variable "admin_password" {}
variable "whitelisted_ips" {
  default = []
}
variable "is_auto_scaling_enabled" {
  default = false
}
variable "is_data_guard_enabled" {
  default = false
}
variable "switchover_to" {
  default = "PRIMARY"
}
variable "is_free_tier" {
  default = true
}
