locals {
  common_labels = {
    environment = "lab"
    managed_by  = "terraform"
    project     = "gke-istio-microservices"
  }

  services = [
    "service1",
    "service2",
    "service3",
    "service4",
    "service5"
  ]
}
