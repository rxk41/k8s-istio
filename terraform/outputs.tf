output "project_id" {
  value = var.project_id
}

output "cluster_name" {
  value = google_container_cluster.gke.name
}

output "cluster_location" {
  value = google_container_cluster.gke.location
}

output "cluster_endpoint" {
  value     = google_container_cluster.gke.endpoint
  sensitive = true
}

output "network_name" {
  value = google_compute_network.gke.name
}

output "subnet_name" {
  value = google_compute_subnetwork.gke.name
}

output "node_pool_name" {
  value = google_container_node_pool.default.name
}

output "node_service_account" {
  value = google_service_account.gke_nodes.email
}

output "get_credentials_command" {
  value = "gcloud container clusters get-credentials ${google_container_cluster.gke.name} --zone ${var.zone} --project ${var.project_id}"
}
