# Copyright © 2020-2021 Collbow All Rights Reserved

variable "tenancy_ocid" {
  description = "Tenancy's OCID used to connect to OCI."
}
variable "user_ocid" {
  description = "User's OCID used to connect to OCI."
}
variable "fingerprint" {
  description = "Fingerprint of the user's API key used to connect to OCI."
}
variable "private_key_path" {
  description = "The path to the private key file of the user's API used to connect to OCI."
  default     = "../../../keys/oci_api_key.pem"
}
variable "private_key_password" {
  description = "User's API private key passphrase used to connect to OCI."
  default     = ""
}
variable "region" {
  description = "Region of OCI to use."
}
variable "compartment_ocid" {
  description = "OCID of the compartment to use. If not set, use the root compartment."
  default     = ""
}
variable "ssh_public_key_path" {
  description = "Public key for SSH connection to the instance."
  default     = "../../../keys/ssh-key.pub"
}
variable "lb_ca_certificate_path" {
  description = "The Certificate Authority certificate file path to set for the load balancer."
  default     = "../../../keys/ca_cert.pem"
}
variable "lb_private_key_path" {
  description = "The SSL private key file path to set for the load balancer."
  default     = "../../../keys/ca_key.pem"
}
variable "lb_passphrase" {
  description = "The passphrase of the private key to set for the load balancer."
  default     = ""
}
variable "lb_public_certificate_path" {
  description = "The PME format public certificate file path to set for the load balancer."
  default     = "../../../keys/ca_cert.pem"
}
