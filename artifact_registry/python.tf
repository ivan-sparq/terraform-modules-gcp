resource "google_artifact_registry_repository" "python" {
  count         = var.format == "PYTHON" ? 1 : 0
  project       = var.project_id
  location      = var.region
  repository_id = var.name
  description   = "${var.format} repository"
  format        = var.format


  depends_on = [
    google_project_service.default,
    google_project_iam_member.admin-sa-compute
  ]

}
