# GitHub Connection Terraform Module

This Terraform module creates and configures a GitHub connection for Google Cloud Build V2, enabling seamless integration between GitHub repositories and Google Cloud Build pipelines.

## Features

- Creates a Cloud Build V2 connection to GitHub
- Configures necessary IAM permissions for Cloud Build service account
- Sets up Secret Manager access for GitHub token

## Prerequisites

Before using this module, you need to:

1. Have a GitHub App installed in your organization/account
2. Store your GitHub token in Google Secret Manager
3. Have the necessary IAM permissions to create resources in your GCP project

## Usage

```hcl
module "github_connection" {
  source = "./modules/github_connection"

  project_id                = "your-project-id"
  project_number           = "your-project-number"
  region                   = "europe-west4"
  github_owner             = "your-github-org"
  github_app_installation_id = 12345678
  github_token_secret_id   = "projects/123456789/secrets/github-token/versions/1"
}
```

### Steps to create a GitHub App

1. Create and install a [GitHub App](https://github.com/apps/google-cloud-build) in your organization/account
1. Create a personal access token.
   Make sure to set your token to have no expiration date and select the following permissions when prompted in GitHub: `repo` and `read:user`.
   If your app is installed in an organization, make sure to also select the `read:org` permission.
   Store the token in a safe place, you will need it in the next steps
1. Go to the GitHub App you created in Step 1
1. Click on the `Configure` button
1. Note the URL in the browser address bar. It should look like `https://github.com/settings/installations/1234567`
1. Copy the `1234567` part of the URL. This is your GitHub App installation ID (`github_app_installation_id`)

1. Store the GitHub App's token in Google Secret Manager
1. Provide the following values when applying the Terraform configuration:

   - `github_app_installation_id`: The installation ID of your GitHub App
   - `github_token_secret_id`: The full path to your GitHub token in Secret Manager (format: projects/_/secrets/_/versions/\*)

The connection will be created in the region specified by your region variable, and it will use the existing project ID and GitHub repository information you've already configured.

## Required Variables

| Name                         | Description                                                                      | Type     | Required |
| ---------------------------- | -------------------------------------------------------------------------------- | -------- | :------: |
| `project_id`                 | Google Cloud Platform Project ID                                                 | `string` |   yes    |
| `project_number`             | GCP Project Number                                                               | `string` |   yes    |
| `region`                     | Region to use (e.g., `europe-west4`)                                             | `string` |   yes    |
| `github_owner`               | Name of the GitHub organization the repo belongs to                              | `string` |   yes    |
| `github_app_installation_id` | Installation ID of the GitHub App                                                | `number` |   yes    |
| `github_token_secret_id`     | Secret Manager ID of the GitHub token (format: projects/_/secrets/_/versions/\*) | `string` |   yes    |

## Resources Created

This module creates the following resources:

1. `google_cloudbuildv2_connection`: Creates the GitHub connection in Cloud Build V2
2. `google_secret_manager_secret_iam_policy`: Sets up IAM policy for Secret Manager access
3. IAM bindings for the Cloud Build service account

## Notes

- The Cloud Build service account will be granted access to the GitHub token in Secret Manager
- The connection name will be automatically generated using the format: `{github_owner}-connection`
- Make sure the GitHub token has the necessary permissions to access your repositories

## License

This module is released under the MIT License.

## References

- [Grant a role to the Cloud Build service agent](https://cloud.google.com/build/docs/securing-builds/configure-access-for-cloud-build-service-account#service-agent-permissions)
