locals {
  # For more information on the Cloud Build Service Agent, see: 
  #   https://cloud.google.com/build/docs/securing-builds/configure-access-for-cloud-build-service-account
  cloudbuild_service_agent = "service-${data.google_project.default.number}@gcp-sa-cloudbuild.iam.gserviceaccount.com"
}

data "google_project" "default" {
  project_id = var.project_id
}

resource "google_project_iam_member" "cloudbuild_service_agent" {
  project = var.project_id
  role    = "roles/cloudbuild.serviceAgent"
  member  = "serviceAccount:${local.cloudbuild_service_agent}"
}

#  add a delay to ensure the Cloud Build Service Agent has time to propagate
resource "time_sleep" "wait_30_seconds" {
  depends_on      = [google_project_iam_member.cloudbuild_service_agent]
  create_duration = "30s"
}

resource "google_secret_manager_secret_iam_member" "github_token_secret_access" {
  project   = var.project_id
  secret_id = var.github_token_secret_id
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:${local.cloudbuild_service_agent}"

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [time_sleep.wait_30_seconds]
}

// Create the GitHub connection
resource "google_cloudbuildv2_connection" "my_connection" {
  project  = var.project_id
  location = var.region
  name     = "${var.github_owner}-connection"

  github_config {
    app_installation_id = var.github_app_installation_id
    authorizer_credential {
      oauth_token_secret_version = var.github_token_secret_version
    }
  }
  depends_on = [
    google_secret_manager_secret_iam_member.github_token_secret_access,
    time_sleep.wait_30_seconds
  ]
}

output "github_connection_name" {
  value = google_cloudbuildv2_connection.my_connection.name
}
