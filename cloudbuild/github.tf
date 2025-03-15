/**
Creates a Service Account for GitHub Actions to authenticate to Google Cloud using Workload Identity Federation
and sets up a second-generation GitHub repository connection for Cloud Build
**/

resource "google_service_account" "github_actions" {
  account_id   = "sa-github-actions"
  display_name = "GitHub Actions"
  description  = "GitHub Actions Service Account authenticated via Workload Identity Federation"
}

resource "google_project_iam_member" "github_actions" {
  for_each = local.all_roles
  project  = var.project_id
  role     = each.key
  member   = "serviceAccount:${google_service_account.github_actions.email}"
}

# Second-generation GitHub repository connection
resource "google_cloudbuildv2_repository" "github_repo" {
  name              = "${var.github_repo}-connection"
  location          = var.region
  parent_connection = var.github_connection_name
  remote_uri        = "https://github.com/${var.github_owner}/${var.github_repo}.git"
  depends_on        = [google_project_service.default]
}


############### authenticate from GitHub Actions to Google Cloud using Workload Identity Federation ###############
module "gh_oidc" {
  count                 = var.enable_gha_auth ? 1 : 0
  source                = "terraform-google-modules/github-actions-runners/google//modules/gh-oidc"
  project_id            = var.project_id
  pool_id               = "gh-actions-pool"
  pool_display_name     = "GitHub Actions Pool"
  provider_id           = "gh-actions"
  provider_display_name = "GitHub Actions"
  attribute_mapping = {
    "google.subject"             = "assertion.sub"
    "attribute.repository_owner" = "assertion.repository_owner"
  }
  attribute_condition = "assertion.repository_owner == '${var.github_owner}'"
  sa_mapping = {
    # "gha-this-org" = {
    #   sa_name   = google_service_account.github_actions.id
    #   attribute = "attribute.repository_owner/${var.github_owner}"
    # },
    "gha-this-repo-only" = {
      sa_name   = google_service_account.github_actions.id
      attribute = "attribute.repository/${var.github_owner}/${var.github_repo}"
    }
  }
}


output "gh_oidc_pool_name" {
  value = var.enable_gha_auth ? module.gh_oidc[0].pool_name : ""
}
output "gh_oidc_provider_name" {
  value = var.enable_gha_auth ? module.gh_oidc[0].provider_name : ""
}
output "gh_oidc_sa_email" {
  value = google_service_account.github_actions.email
}
