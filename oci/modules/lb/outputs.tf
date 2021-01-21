# Copyright © 2020-2021 Collbow All Rights Reserved

output "lb_public_ip" {
  value = oci_core_public_ip.lb_public_ip.ip_address
}
