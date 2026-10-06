resource "google_compute_network" "gke" {
  name = var.network_name

  auto_create_subnetworks = false

  routing_mode = "REGIONAL"

  depends_on = [
    google_project_service.required
  ]
}

resource "google_compute_subnetwork" "gke" {
  name = var.subnet_name

  region = var.region

  network = google_compute_network.gke.id

  ip_cidr_range = "10.10.0.0/20"

  secondary_ip_range {
    range_name    = "gke-pods"
    ip_cidr_range = "10.20.0.0/16"
  }

  secondary_ip_range {
    range_name    = "gke-services"
    ip_cidr_range = "10.30.0.0/20"
  }

  private_ip_google_access = true

  log_config {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}
