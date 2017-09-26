output "cidr" {
  value = "${data.google_compute_subnetwork.default.ip_cidr_range}"
}

output "region" {
  value = "${var.region}"
}
