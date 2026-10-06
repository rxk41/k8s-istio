variable "project_id" {
  description = "Google Cloud project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "GCP zone"
  type        = string
  default     = "us-central1-a"
}

variable "cluster_name" {
  description = "GKE cluster name"
  type        = string
  default     = "gke-istio-lab"
}

variable "network_name" {
  description = "VPC network name"
  type        = string
  default     = "gke-istio-vpc"
}

variable "subnet_name" {
  description = "GKE subnet name"
  type        = string
  default     = "gke-istio-subnet"
}

variable "node_machine_type" {
  description = "Machine type for the single lab node"
  type        = string
  default     = "e2-small"
}

variable "node_count" {
  description = "Number of nodes in the lab node pool"
  type        = number
  default     = 1
}

variable "billing_account_id" {
  description = "Optional billing account ID, e.g. 000000-000000-000000"
  type        = string
  default     = ""
}

variable "create_budget" {
  description = "Create a billing budget for the project"
  type        = bool
  default     = false
}

variable "budget_amount_usd" {
  description = "Budget threshold in USD"
  type        = number
  default     = 10
}
