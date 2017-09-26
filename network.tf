data "google_compute_zones" "available" {}

data "google_compute_subnetwork" "default" {
  name   = "default"
  region = "${var.region}"
}
