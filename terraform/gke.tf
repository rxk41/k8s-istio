resource "google_container_cluster" "gke" {
  name     = var.cluster_name
  location = var.zone

  network    = google_compute_network.gke.id
  subnetwork = google_compute_subnetwork.gke.id

  networking_mode = "VPC_NATIVE"

  deletion_protection = false

  remove_default_node_pool = true

  initial_node_count = 1

  release_channel {
    channel = "REGULAR"
  }

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = "gke-pods"
    services_secondary_range_name = "gke-services"
  }

  addons_config {
    http_load_balancing {
      disabled = false
    }

    horizontal_pod_autoscaling {
      disabled = false
    }

    gce_persistent_disk_csi_driver_config {
      enabled = true
    }
  }

  resource_labels = local.common_labels

  maintenance_policy {
    recurring_window {
      start_time = "2026-01-01T02:00:00Z"
      end_time   = "2026-01-01T06:00:00Z"

      recurrence = "FREQ=WEEKLY;BYDAY=SA"
    }
  }

  depends_on = [
    google_project_service.required,
    google_project_iam_member.gke_node_default,
    google_compute_subnetwork.gke
  ]
}


resource "google_container_node_pool" "default" {
  name     = "default-pool"
  location = var.zone
  cluster  = google_container_cluster.gke.name

  node_count = var.node_count

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  upgrade_settings {
    strategy = "SURGE"

    max_surge       = 1
    max_unavailable = 0
  }

  node_config {
    machine_type = var.node_machine_type

    disk_type    = "pd-standard"
    disk_size_gb = 30

    image_type = "COS_CONTAINERD"

    service_account = google_service_account.gke_nodes.email

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]

    labels = {
      environment = "lab"
      node_pool   = "default"
    }

    tags = [
      "gke-istio-lab"
    ]

    workload_metadata_config {
      mode = "GKE_METADATA"
    }
  }

  depends_on = [
    google_container_cluster.gke,
    google_project_iam_member.gke_node_logging,
    google_project_iam_member.gke_node_monitoring
  ]
}
