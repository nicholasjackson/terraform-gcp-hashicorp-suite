variable "namespace" {
  default = "nomadgcp"
}

variable "region" {
  default = "us-central1"
}

variable "zone" {
  default = "us-central1-a"
}

variable "cidr_block" {
  default = "10.128.0.0/9"
}

provider "google" {
  region  = "${var.region}"
  project = "nomad-multi-cloud"
}

resource "google_compute_network" "nomad" {
  name                    = "${var.namespace}-nomad"
  auto_create_subnetworks = "true"
}

resource "google_compute_firewall" "internal" {
  name          = "internal"
  network       = "${google_compute_network.nomad.name}"
  source_ranges = ["${var.cidr_block}"]

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }
}

resource "google_compute_firewall" "external" {
  name          = "external"
  network       = "${google_compute_network.nomad.name}"
  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  allow {
    protocol = "udp"
  }
}

module "gcp" {
  source = "/Users/nicj/Developer/terraform/terraform-gcp-hashicorp-suite"

  namespace = "${var.namespace}"
  zone      = "${var.zone}"

  min_servers = "1"
  max_servers = "3"
  min_agents  = "3"
  max_agents  = "5"

  vpc_id   = "${google_compute_network.nomad.name}"
  key_name = "~/.ssh/id_rsa.pub"

  /*
  client_target_groups = ["${aws_alb_target_group.proxy.arn}"]
  server_target_groups = ["${aws_alb_target_group.nomad.arn}"]
  */

  consul_enabled        = true
  consul_version        = "1.0.6"
  consul_join_tag_key   = "autojoin"
  consul_join_tag_value = "${var.namespace}"
  nomad_enabled         = true
  nomad_version         = "0.7.1"
}
