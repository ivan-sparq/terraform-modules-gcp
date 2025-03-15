
data "google_compute_default_service_account" "default" {
}

data "google_project" "default" {
  project_id = var.project_id
}


# enable API
resource "google_project_service" "default" {
  for_each = toset([
    "cloudbuild.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "compute.googleapis.com",
    "iam.googleapis.com",
    "iamcredentials.googleapis.com",
    "resourceviews.googleapis.com",
    "secretmanager.googleapis.com",
    "serviceusage.googleapis.com",
    "storage-api.googleapis.com",
    "sts.googleapis.com",
  ])
  project            = var.project_id
  service            = each.value
  disable_on_destroy = false
}
