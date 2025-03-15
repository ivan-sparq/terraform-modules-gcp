data "google_project" "default" {
  project_id = var.project_id
}


resource "google_project_service" "default" {
  for_each = toset([
    "artifactregistry.googleapis.com",
    "cloudbuild.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "compute.googleapis.com",
    "iamcredentials.googleapis.com",
    "secretmanager.googleapis.com"
    "serviceusage.googleapis.com",
  ])
  service            = each.key
  project            = var.project_id
  disable_on_destroy = false
}

