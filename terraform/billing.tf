resource "google_billing_budget" "lab" {
  count = var.create_budget && var.billing_account_id != "" ? 1 : 0

  billing_account = var.billing_account_id
  display_name    = "GKE Istio Lab Budget"

  budget_filter {
    projects = [
      "projects/${var.project_id}"
    ]
  }

  amount {
    specified_amount {
      currency_code = "INR"
      units         = tostring(var.budget_amount_usd)
    }
  }

  threshold_rules {
    threshold_percent = 0.50
  }

  threshold_rules {
    threshold_percent = 0.80
  }

  threshold_rules {
    threshold_percent = 1.00
  }
}
