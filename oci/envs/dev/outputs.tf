# Copyright © 2020-2021 Collbow All Rights Reserved

output "instance_public_ips" {    
  description = "The public IP address of the instances."
  value = [
    for compute in module.dev_compute :
    compute.instance_public_ip
  ]
}
output "lb_public_ip" {
  description = "The public IP address of the load balancer."
  value = module.dev_lb.lb_public_ip
}
output "adb_connection_strings" {
  description = "The connection string used to connect to the Autonomous Database."
  value = [
    for adp in module.dev_adb :
    adp.adb_connection_strings
  ]
}
