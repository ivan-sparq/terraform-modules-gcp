locals {
  admin_roles = [
    "roles/artifactregistry.admin",
    "roles/compute.instanceAdmin.v1",
    "roles/iam.securityAdmin"
  ]
  sa_read_map  = { for idx, sa in var.sa_read : idx => sa }
  sa_write_map = { for idx, sa in var.sa_write : idx => sa }

  repository_map = {
    "DOCKER" = google_artifact_registry_repository.docker
    "PYTHON" = google_artifact_registry_repository.python
  }

  repository = local.repository_map[var.format]
}

#  Default compute account is the admin (assuming this is the SA that runs terraform)
resource "google_project_iam_member" "sa_admin" {
  for_each = toset(local.admin_roles)
  project  = var.project_id
  role     = each.value
  member   = "serviceAccount:${var.admin_service_account}"
}


resource "google_artifact_registry_repository_iam_member" "sa_read" {
  for_each = local.sa_read_map

  location   = local.repository.location
  repository = local.repository.name
  role       = "roles/artifactregistry.reader"
  member     = "serviceAccount:${each.value}"
  depends_on = [google_project_iam_member.sa_admin]
}


resource "google_artifact_registry_repository_iam_member" "sa_write" {
  for_each = local.sa_write_map

  location   = local.repository.location
  repository = local.repository.name
  role       = "roles/artifactregistry.writer"
  member     = "serviceAccount:${each.value}"
  depends_on = [google_project_iam_member.sa_admin]
}
