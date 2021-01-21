# Copyright © 2020-2021 Collbow All Rights Reserved

output "vcn_id" {
  value = oci_core_vcn.vcn.id
}
output "default_route_table_id" {
  value = oci_core_route_table.default_route_table.id
}
output "default_security_list_id" {
  value = oci_core_security_list.default_security_list.id
}
