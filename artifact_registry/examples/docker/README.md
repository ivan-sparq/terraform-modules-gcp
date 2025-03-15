# Docker Repository Example

This example demonstrates how to create a Docker repository in Artifact Registry with common configurations:

- Enables cleanup of untagged images
- Makes tags immutable once pushed
- Sets up read access for CI/CD service accounts
- Sets up write access for publishing service accounts

## Usage

To run this example you need to:

1. Replace `my-project-id` with your GCP project ID
2. Update the service account email addresses to match your project's service accounts
3. Run the following commands:

```bash
terraform init
terraform plan
terraform apply
```

## Notes

- The example assumes you're using GitHub Actions and Cloud Build for CI/CD
- The example enables cleanup of untagged images to save storage costs
- Tag immutability is enabled to prevent accidental overwrites of existing tags

## Requirements

The service account running Terraform needs the following roles:

- Artifact Registry Administrator: `roles/artifactregistry.admin`
- IAM Admin: `roles/iam.admin`
- Service Usage Admin: `roles/serviceusage.serviceUsageAdmin`
