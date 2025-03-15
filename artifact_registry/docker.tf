resource "google_artifact_registry_repository" "docker" {
  count         = var.format == "DOCKER" ? 1 : 0
  project       = var.project_id
  location      = var.region
  repository_id = var.name
  description   = "${var.format} repository"
  format        = var.format


  docker_config {
    immutable_tags = var.docker_immutable_tags
  }

  dynamic "cleanup_policies" {
    for_each = var.docker_delete_untagged ? [1] : []
    content {
      id     = "delete-untagged"
      action = "DELETE"
      condition {
        tag_state = "UNTAGGED"
      }
    }
  }

  depends_on = [
    google_project_service.default,
    google_project_iam_member.sa_admin
  ]
}
