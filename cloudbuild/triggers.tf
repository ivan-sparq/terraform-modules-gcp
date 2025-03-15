resource "google_cloudbuild_trigger" "tf_push" {
  count       = var.enable_tf_triggers ? 1 : 0
  name        = "TERRAFORM-${upper(var.github_branch)}-PUSH"
  description = "[Terraform] Apply configuration"
  filename    = "${var.config_dir}/tofu-apply.yaml"

  repository_event_config {
    repository = google_cloudbuildv2_repository.github_repo.id

    push {
      branch       = "^${var.github_branch}$"
      invert_regex = false
    }
  }

  substitutions = {
    _ENV      = var.env
    _DO_APPLY = "true"
  }

  location           = var.region
  include_build_logs = "INCLUDE_BUILD_LOGS_WITH_STATUS"
  service_account    = google_service_account.default.id
  depends_on = [
    google_project_service.default,
    google_project_iam_member.cloudbuild_roles,
    google_cloudbuildv2_repository.github_repo
  ]
}

resource "google_cloudbuild_trigger" "tf_pr" {
  count       = var.enable_tf_triggers ? 1 : 0
  name        = "TERRAFORM-${upper(var.github_branch)}-PR"
  description = "[Terraform] Plan configuration"
  filename    = "${var.config_dir}/tofu-apply.yaml"

  repository_event_config {
    repository = google_cloudbuildv2_repository.github_repo.id

    pull_request {
      branch       = "^${var.github_branch}$"
      invert_regex = false
    }
  }

  substitutions = {
    _ENV      = var.env
    _DO_APPLY = "false"
  }

  location           = var.region
  include_build_logs = "INCLUDE_BUILD_LOGS_WITH_STATUS"
  service_account    = google_service_account.default.id
  depends_on = [
    google_project_service.default,
    google_project_iam_member.cloudbuild_roles,
    google_cloudbuildv2_repository.github_repo
  ]
}
