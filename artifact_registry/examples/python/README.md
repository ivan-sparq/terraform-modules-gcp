# Python Repository Example

This example demonstrates how to create a Python package repository in Artifact Registry with typical configurations for managing private Python packages.

## Features

- Creates a Python package repository
- Sets up read access for CI and development service accounts
- Sets up write access for package publishing service accounts

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

## Using the Repository

After creation, you can use the repository with pip by:

1. Authenticating with gcloud:

```bash
gcloud auth login
```

2. Installing packages:

```bash
pip install --index-url https://europe-west2-python.pkg.dev/my-project-id/python-packages/simple/ my-package
```

3. Publishing packages (with appropriate credentials):

```bash
python -m twine upload --repository-url https://europe-west2-python.pkg.dev/my-project-id/python-packages/ dist/*
```

## Requirements

The service account running Terraform needs the following roles:

- Artifact Registry Administrator: `roles/artifactregistry.admin`
- IAM Admin: `roles/iam.admin`
- Service Usage Admin: `roles/serviceusage.serviceUsageAdmin`
