# Copyright © 2020-2021 Collbow All Rights Reserved

output "adb_connection_strings" {
  value = oci_database_autonomous_database.adb.connection_strings
}
