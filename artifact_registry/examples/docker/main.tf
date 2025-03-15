provider "google" {
  project = "my-project-id"
  region  = "europe-west2"
}

module "docker_registry" {
  source = "github.com/ivan-sparq/terraform-modules-gcp//artifact_registry"

  project_id = "my-project-id"
  region     = "europe-west2"
  name       = "docker-repository"
  format     = "DOCKER"

  # The service account that will be used to run Terraform and will be given admin access
  admin_service_account = "terraform@my-project-id.iam.gserviceaccount.com"

  # Service accounts that will have read access to the repository
  sa_read = [
    "github-actions@my-project-id.iam.gserviceaccount.com",
    "cloud-build@my-project-id.iam.gserviceaccount.com"
  ]

  # Service accounts that will have write access to the repository
  sa_write = [
    "docker-publisher@my-project-id.iam.gserviceaccount.com"
  ]

  # Enable cleanup of untagged images
  docker_delete_untagged = true

  # Make tags immutable once pushed
  docker_immutable_tags = true
}
