locals {

  default_roles = toset([
    "roles/iam.roleViewer",
    "roles/iam.serviceAccountAdmin",
    "roles/iam.serviceAccountUser",
    "roles/iam.workloadIdentityPoolAdmin",
    "roles/secretmanager.admin",
    "roles/storage.objectCreator",
    "roles/storage.admin",
    "roles/cloudbuild.connectionAdmin",
  ])

  all_roles = toset(flatten([local.default_roles, var.roles]))
}


resource "google_service_account" "default" {
  account_id   = var.sa_name
  display_name = "Cloud Build Service Account"
  description  = "Service account for Cloud Build. Replaces the default and compute SA"
}

resource "google_project_iam_member" "cloudbuild_roles" {
  for_each = local.all_roles
  project  = var.project_id
  role     = each.key
  member   = "serviceAccount:${google_service_account.default.email}"
}
resource "google_project_iam_member" "cloudbuild_sa" {
  project = var.project_id
  role    = "roles/cloudbuild.builds.builder"
  member  = "serviceAccount:${google_service_account.default.email}"
}

# Output the email for use in other resources
output "service_account_email" {
  value       = google_service_account.default.email
  description = "The email address of the service account"
}
