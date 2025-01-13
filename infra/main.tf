provider "google" {
  credentials = file("./key.json")
  project     = var.project_id
  region      = var.default_region
}

resource "google_cloud_run_v2_service" "rails-cloud-run" {
  name     = "rails-cloud-run"
  location = var.default_region
  ingress = "INGRESS_TRAFFIC_ALL"

  template {
    scaling {
      max_instance_count = 1
    }
    containers {
      image = "gcr.io/${var.project_id}/rails-cloud-run:latest"
      env {
        name  = "RAILS_MASTER_KEY"
        value = var.RAILS_MASTER_KEY
      }
      env {
        name = "DB_HOST"
        value = var.DB_HOST
      }
      env {
        name = "DB_PORT"
        value = var.DB_PORT
      }
      env {
        name = "DB_NAME"
        value = var.DB_NAME
      }
      env {
        name = "DB_USER"
        value = var.DB_USER
      }
      env {
        name = "DB_PASS"
        value = var.DB_PASS
      }
    }
  }

  traffic {
    percent         = 100
    type = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
  }
}

data "google_iam_policy" "noauth" {
  binding {
    role    = "roles/run.invoker"
    members = ["allUsers"]
  }
}

resource "google_cloud_run_v2_service_iam_policy" "policy" {
  location    = google_cloud_run_v2_service.rails-cloud-run.location
  name        = google_cloud_run_v2_service.rails-cloud-run.name
  policy_data = data.google_iam_policy.noauth.policy_data
}
