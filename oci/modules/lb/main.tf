# Copyright © 2020-2021 Collbow All Rights Reserved

resource "oci_core_public_ip" "lb_public_ip" {
  compartment_id = var.compartment_ocid
  display_name   = "${var.management_label}_public_ip"
  lifetime       = "RESERVED"
}

resource "oci_load_balancer" "lb" {
  compartment_id = var.compartment_ocid
  display_name   = var.management_label
  shape          = var.shape
  shape_details {
    maximum_bandwidth_in_mbps = var.maximum_bandwidth_in_mbps
    minimum_bandwidth_in_mbps = var.minimum_bandwidth_in_mbps
  }
  reserved_ips {
    id = oci_core_public_ip.lb_public_ip.id
  }
  subnet_ids = var.subnet_ids
}

resource "oci_load_balancer_backend_set" "lb_backend_set" {
  name             = "${var.management_label}_backend_set"
  load_balancer_id = oci_load_balancer.lb.id
  policy           = var.policy
  health_checker {
    protocol            = "HTTP"
    response_body_regex = var.health_checker_response_body_regex
    url_path            = var.health_checker_url_path
  }
}

resource "oci_load_balancer_backend" "lb_backend" {
  count            = length(var.backend_server)
  load_balancer_id = oci_load_balancer.lb.id
  backendset_name  = oci_load_balancer_backend_set.lb_backend_set.name
  ip_address       = var.backend_server[count.index].ip_address
  port             = var.backend_server[count.index].port
}

resource "oci_load_balancer_certificate" "lb_certificate" {
  load_balancer_id   = oci_load_balancer.lb.id
  certificate_name   = var.certificate_name
  ca_certificate     = var.ca_certificate
  private_key        = var.private_key
  passphrase         = var.passphrase
  public_certificate = var.public_certificate
  lifecycle {
    create_before_destroy = true
  }
}

resource "oci_load_balancer_listener" "lb_listener_https" {
  load_balancer_id         = oci_load_balancer.lb.id
  name                     = "${var.management_label}_listener_https"
  default_backend_set_name = oci_load_balancer_backend_set.lb_backend_set.name
  port                     = 443
  protocol                 = "HTTP"
  ssl_configuration {
    certificate_name        = oci_load_balancer_certificate.lb_certificate.certificate_name
    verify_peer_certificate = var.verify_peer_certificate
  }
}
