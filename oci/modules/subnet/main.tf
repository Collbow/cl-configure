# Copyright © 2020-2021 Collbow All Rights Reserved

resource "oci_core_subnet" "subnet" {
  compartment_id      = var.compartment_ocid
  display_name        = "${var.management_label} ${var.cidr_block}"
  availability_domain = var.availability_domain
  vcn_id              = var.vcn_id
  security_list_ids   = var.security_list_ids
  route_table_id      = var.route_table_id
  dns_label           = var.management_label
  cidr_block          = var.cidr_block
}
