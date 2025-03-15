# Cloud Build Terraform Module

This module provides a comprehensive setup for Google Cloud Build with GitHub integration:

- Creates and configures necessary service accounts and permissions for Cloud Build operations
- Sets up GitHub repository integration for automated builds
- Creates Terraform plan (PR) and apply (merge) triggers for specified branches
- Configures monitoring and alerting for build failures
- Optionally enables GitHub Actions authentication with GCP using Workload Identity Federation

## Usage

### Basic Configuration

```hcl
module "cloudbuild" {
  source              = "github.com/ivan-sparq/terraform-modules-gcp//cloudbuild"
  project_id          = var.project_id
  region              = var.region
  github_owner        = "my-organization"
  github_repo         = "my-repo"
  github_branch       = "main"
  github_connection_name = "my-github-connection"
  env                 = "dev"
  config_dir          = "deployment/cloudbuild"

  # Optional configurations
  roles = [
    "roles/run.admin",
    "roles/appengine.appAdmin",
    "roles/cloudfunctions.developer",
    "roles/secretmanager.admin",
    "roles/iam.serviceAccountUser"
  ]
  enable_tf_triggers = true
  enable_gha_auth    = false
}
```

## Input Variables

| Name                     | Type        | Description                                                                                         |
| ------------------------ | ----------- | --------------------------------------------------------------------------------------------------- |
| `project_id`             | string      | Google Cloud Platform Project                                                                       |
| `region`                 | string      | Region to use e.g. `europe-west4`.                                                                  |
| `github_owner`           | string      | Name github org the repo belongs to                                                                 |
| `github_repo`            | string      | Name github repo to create a trigger for                                                            |
| `github_branch`          | string      | Create Terraform triggers for this branch (e.a. develop or main)                                    |
| `github_connection_name` | string      | The name of the GitHub connection (See below on how to create that )                                |
| `env`                    | string      | Name of terraform/tofu workspace                                                                    |
| `config_dir`             | string      | Directory of CloudBuild YAML files, relative to the root of the repo                                |
| `roles`                  | set(string) | Extra roles to be given to the Cloud Build (and Github Actions) service account(s)                  |
| `sa_name`                | string      | The name of the service account to create that will be running the triggers                         |
| `enable_tf_triggers`     | bool        | Create Terraform triggers when creating a PR to `github_branch` and when merging to `github_branch` |
| `enable_gha_auth`        | bool        | Authenticate GitHub Actions with GCP using Workload Identity Federation                             |

## Features

### Cloud Build GitHub Integration

This module supports two types of GitHub integration:

1. **Native Cloud Build GitHub Integration** - For triggering builds directly from GitHub events
2. **GitHub Actions Authentication** - For authenticating GitHub Actions workflows with GCP (when `enable_gha_auth = true`)

### Terraform Automation

When `enable_tf_triggers = true`, the module creates two Cloud Build triggers:

- **PR Trigger**: Runs `terraform plan` when a pull request is created/updated
- **Merge Trigger**: Runs `terraform apply` when changes are merged to the specified branch

## Setup Instructions

### 1. GitHub Connection Setup

Follow these steps to connect your GitHub repository to Cloud Build:

1. Ensure you have admin-level permissions on your GitHub repository
2. Install and authenticate the gcloud CLI
3. Follow the [official documentation](https://cloud.google.com/build/docs/automating-builds/github/connect-repo-github?generation=2nd-gen) to set up the GitHub connection

### 2. GitHub Actions Authentication (Optional)

If `enable_gha_auth = true`, follow these steps after applying the Terraform configuration:

1. Create a new GitHub environment matching your Terraform environment name (e.g., `dev`)
2. Add these environment variables:
   - `GH_OIDC_SA_EMAIL`: Value from the `gh_oidc_sa_email` output
   - `GH_OIDC_PROVIDER_NAME`: Value from the `gh_oidc_provider_name` output

## Additional Resources

- [Cloud Build GitHub Integration Documentation](https://cloud.google.com/build/docs/automating-builds/github/connect-repo-github)
- [Workload Identity Federation](https://cloud.google.com/iam/docs/workload-identity-federation)
- [GitHub Actions Authentication](https://github.com/google-github-actions/auth)
