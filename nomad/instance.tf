data "template_file" "config_consul" {
  template = "${file("${path.module}/templates/consul-${var.consul_type}.json.tpl")}"

  vars {
    instances             = "${var.min_instances}"
    datacenter            = "${var.nomad_datacentre}"
    consul_join_tag_value = "${var.consul_join_tag_key}"
    consul_wan            = "${var.consul_wan}"
  }
}

data "template_file" "config_nomad" {
  template = "${file("${path.module}/templates/nomad-${var.nomad_type}.hcl.tpl")}"

  vars {
    instances  = "${var.min_instances}"
    datacenter = "${var.nomad_datacentre}"
    region     = "${var.nomad_region}"
  }
}

data "template_file" "startup" {
  template = "${file("${path.module}/templates/startup.sh.tpl")}"

  vars {
    consul_enabled = "${var.consul_enabled}"
    consul_version = "${var.consul_version}"

    consul_type = "${var.consul_type}"

    consul_config = "${data.template_file.config_consul.rendered}"

    nomad_enabled = "${var.nomad_enabled}"
    nomad_version = "${var.nomad_version}"

    nomad_type = "${var.nomad_type}"

    nomad_config = "${data.template_file.config_nomad.rendered}"
  }
}

resource "google_compute_instance_template" "nomad" {
  name           = "nomad-cluster-${var.nomad_type}"
  machine_type   = "${var.instance_type}"
  can_ip_forward = false

  disk {
    source_image = "${var.source_image}"
  }

  network_interface {
    network = "${var.network_name}"

    access_config {}
  }

  tags = ["${var.consul_join_tag_key}"]

  metadata {
    sshKeys = "ubuntu:${file(var.key_name)}"
  }

  metadata_startup_script = "${data.template_file.startup.rendered}"

  service_account {
    scopes = ["https://www.googleapis.com/auth/compute.readonly"]
  }
}

resource "google_compute_target_pool" "nomad" {
  name = "nomad-cluster-${var.nomad_type}"

  session_affinity = "NONE"
}

resource "google_compute_instance_group_manager" "nomad" {
  name = "nomad-${var.nomad_type}"
  zone = "${var.zone}"

  instance_template  = "${google_compute_instance_template.nomad.self_link}"
  target_pools       = ["${google_compute_target_pool.nomad.self_link}"]
  base_instance_name = "nomad"
}

resource "google_compute_autoscaler" "nomad" {
  name   = "nomad-${var.nomad_type}"
  zone   = "${var.zone}"
  target = "${google_compute_instance_group_manager.nomad.self_link}"

  autoscaling_policy = {
    max_replicas    = "${var.max_instances}"
    min_replicas    = "${var.min_instances}"
    cooldown_period = 60

    cpu_utilization {
      target = 0.5
    }
  }
}
