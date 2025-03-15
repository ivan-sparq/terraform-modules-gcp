provider "google" {
  project = "my-project-id"
  region  = "europe-west2"
}

module "python_registry" {
  source = "github.com/ivan-sparq/terraform-modules-gcp//artifact_registry"

  project_id = "my-project-id"
  region     = "europe-west2"
  name       = "python-packages"
  format     = "PYTHON"

  # The service account that will be used to run Terraform and will be given admin access
  admin_service_account = "terraform@my-project-id.iam.gserviceaccount.com"

  # Service accounts that will have read access to the repository
  sa_read = [
    "python-ci@my-project-id.iam.gserviceaccount.com",
    "python-dev@my-project-id.iam.gserviceaccount.com"
  ]

  # Service accounts that will have write access to the repository (package publishers)
  sa_write = [
    "python-publisher@my-project-id.iam.gserviceaccount.com"
  ]
}
