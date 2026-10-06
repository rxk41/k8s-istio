resource "google_service_account" "gke_nodes" {
  account_id   = "gke-lab-nodes"
  display_name = "GKE Lab Node Service Account"

  depends_on = [
    google_project_service.required
  ]
}
resource "google_project_iam_member" "gke_node_default" {
  project = var.project_id

  role   = "roles/container.defaultNodeServiceAccount"
  member = "serviceAccount:${google_service_account.gke_nodes.email}"
}
resource "google_project_iam_member" "gke_node_logging" {
  project = var.project_id

  role   = "roles/logging.logWriter"
  member = "serviceAccount:${google_service_account.gke_nodes.email}"
}
resource "google_project_iam_member" "gke_node_monitoring" {
  project = var.project_id

  role   = "roles/monitoring.metricWriter"
  member = "serviceAccount:${google_service_account.gke_nodes.email}"
}
