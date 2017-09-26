resource "google_compute_firewall" "default" {
  name    = "${var.namespace}-firewall"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["www"]
}
