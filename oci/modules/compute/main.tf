# Copyright © 2020-2021 Collbow All Rights Reserved

data "oci_core_images" "images" {
  compartment_id           = var.compartment_ocid
  shape                    = var.shape
  operating_system         = var.operating_system
  operating_system_version = var.operating_system_version
  sort_by                  = "TIMECREATED"
  sort_order               = "DESC"
}

resource "oci_core_instance" "instance" {
  compartment_id      = var.compartment_ocid
  display_name        = var.management_label
  availability_domain = var.availability_domain
  shape               = var.shape
  source_details {
    source_type = "image"
    source_id   = data.oci_core_images.images.images[0].id
    boot_volume_size_in_gbs = var.boot_volume_size_in_gbs
  }
  create_vnic_details {
    display_name     = var.management_label == "" ? "" : "${var.management_label} Primary VNIC"
    subnet_id        = var.subnet_id
    assign_public_ip = var.assign_public_ip
    private_ip       = var.private_ip
    hostname_label   = var.management_label
  }
  metadata = {
    ssh_authorized_keys = var.ssh_public_key
  }
  lifecycle {
    ignore_changes = [
      source_details,
      metadata
    ]
  }
}
