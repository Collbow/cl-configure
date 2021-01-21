# Copyright © 2020-2021 Collbow All Rights Reserved

provider "oci" {
  tenancy_ocid         = var.tenancy_ocid
  user_ocid            = var.user_ocid
  fingerprint          = var.fingerprint
  private_key_path     = var.private_key_path
  private_key_password = var.private_key_password
  region               = var.region
}

locals {
  compartment_ocid = var.compartment_ocid == "" ? var.tenancy_ocid : var.compartment_ocid
}

data "oci_identity_availability_domains" "ads" {
  compartment_id = local.compartment_ocid
}

module "dev_vcn" {
  source           = "../../modules/vcn"
  compartment_ocid = local.compartment_ocid
  management_label = "devvcn"
  cidr_block       = "192.168.0.0/16"
}

module "dev_subnet" {
  source              = "../../modules/subnet"
  compartment_ocid    = local.compartment_ocid
  management_label    = "devsubnet"
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  vcn_id              = module.dev_vcn.vcn_id
  route_table_id      = module.dev_vcn.default_route_table_id
  security_list_ids   = [module.dev_vcn.default_security_list_id]
  cidr_block          = "192.168.1.0/24"
}

module "dev_compute" {
  count               = 2
  source              = "../../modules/compute"
  compartment_ocid    = local.compartment_ocid
  management_label    = "dev-compute-${count.index + 1}"
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  subnet_id           = module.dev_subnet.subnet_id
  ssh_public_key      = file(var.ssh_public_key_path)
}

module "dev_lb" {
  source           = "../../modules/lb"
  compartment_ocid = local.compartment_ocid
  management_label = "dev-lb"
  subnet_ids = [module.dev_subnet.subnet_id]
  backend_server = [
    for compute in module.dev_compute :
    {
      ip_address = compute.instance_private_ip
      port       = 80
    }
  ]
  certificate_name   = "dev_lb_certificate"
  ca_certificate     = file(var.lb_ca_certificate_path)
  private_key        = file(var.lb_private_key_path)
  passphrase         = var.lb_passphrase
  public_certificate = file(var.lb_public_certificate_path)
}

module "dev_adb" {
  count            = 2
  source           = "../../modules/adb"
  compartment_ocid = local.compartment_ocid
  management_label = "dev-adb-${count.index + 1}"
  db_name          = "devadb${count.index + 1}"
  admin_password   = "C0llbow_Pass"
}
