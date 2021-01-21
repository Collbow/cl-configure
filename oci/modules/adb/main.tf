# Copyright © 2020-2021 Collbow All Rights Reserved

resource "oci_database_autonomous_database" "adb" {
  compartment_id           = var.compartment_ocid
  display_name             = var.management_label
  cpu_core_count           = var.cpu_core_count
  data_storage_size_in_tbs = var.data_storage_size_in_tbs
  db_version               = var.db_version
  license_model            = var.license_model
  db_workload              = var.db_workload
  db_name                  = var.db_name
  admin_password           = var.admin_password
  whitelisted_ips          = var.whitelisted_ips
  is_auto_scaling_enabled  = var.is_auto_scaling_enabled
  is_data_guard_enabled    = var.is_data_guard_enabled
  switchover_to            = var.switchover_to
  is_free_tier             = var.is_free_tier
  lifecycle {
    ignore_changes = [
      admin_password
    ]
  }
}
