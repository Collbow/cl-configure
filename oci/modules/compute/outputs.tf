# Copyright © 2020-2021 Collbow All Rights Reserved

output "instance_private_ip" {
  value = oci_core_instance.instance.private_ip
}
output "instance_public_ip" {
  value = oci_core_instance.instance.public_ip
}
