# Copyright © 2020-2021 Collbow All Rights Reserved

resource "oci_core_vcn" "vcn" {
  compartment_id = var.compartment_ocid
  display_name   = var.management_label
  cidr_block     = var.cidr_block
  dns_label      = var.management_label
}

resource "oci_core_internet_gateway" "internet_gateway" {
  compartment_id = var.compartment_ocid
  display_name   = var.management_label == "" ? "" : "${var.management_label} Internet Gateway"
  vcn_id         = oci_core_vcn.vcn.id
}

resource "oci_core_route_table" "default_route_table" {
  compartment_id = var.compartment_ocid
  display_name   = var.management_label == "" ? "" : "${var.management_label} Default Route Table"
  vcn_id         = oci_core_vcn.vcn.id
  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.internet_gateway.id
  }
}

resource "oci_core_security_list" "default_security_list" {
  compartment_id = var.compartment_ocid
  display_name   = var.management_label == "" ? "" : "${var.management_label} Default Security List"
  vcn_id         = oci_core_vcn.vcn.id
  egress_security_rules {
    protocol    = "6"
    destination = "0.0.0.0/0"
  }
  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"
    tcp_options {
      max = 22
      min = 22
    }
  }
  ingress_security_rules {
    protocol = "6"
    source   = var.cidr_block
    tcp_options {
      max = 80
      min = 80
    }
  }
  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"
    tcp_options {
      max = 443
      min = 443
    }
  }
}
