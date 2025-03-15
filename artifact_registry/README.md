# Terraform Google Cloud Artifact Registry Module

This module makes it easy to create and manage a single GCP Artifact Registry repository.

Currently only supports Python and Docker.

## Compatibility

This module is compatible with Terraform 1.5 and above.
And it has been tested with OpenTofu 1.9

## Usage

```hcl
module "artifact_registry" {
  source    = "ivan-sparq/terraform-modules-gcp"
  version   = "~> 0.1"
  project_id   = "my-project-id"
  region    = "europe-west2"
  name      = "default-docker-repo"
  format    = "DOCKER"
  sa_read   = ["docker-read-sa@gcp.com"]
  sa_write  = ["docker-write-sa@gcp.com"]
}
```

Functional examples are included in the [examples](./examples) directory.

## Input Variables

| Name                     | Type         | Description                                                                                                                                                                                  |
| ------------------------ | ------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `admin_service_account`  | string       | The service account that will provision the resources and will be given admin access to the artifact registry. Recommended to use the same service account that will run the terraform code. |
| `docker_delete_untagged` | bool         | Whether to enable cleanup policy to delete untagged images                                                                                                                                   |
| `docker_immutable_tags`  | bool         | Prevents existing tags from being modified, moved or deleted. This does not prevent tags from being created.                                                                                 |
| `format`                 | string       | Repository format e.g. `PYTHON` or `DOCKER`                                                                                                                                                  |
| `name`                   | string       | Name of the repository                                                                                                                                                                       |
| `project_id`             | string       | GCP Project ID                                                                                                                                                                               |
| `region`                 | string       | GCP Region                                                                                                                                                                                   |
| `sa_read`                | list(string) | List of service accounts with read access (provide email only )                                                                                                                              |

## Outputs

| Name   | Description                |
| ------ | -------------------------- |
| `name` | The name of the repository |
| `url`  | The URL of the repository  |

## Requirements

### Service Account

User or service account credentials with the following roles must be used to provision the resources of this module:

- `roles/iam.roleViewer`
- `roles/iam.serviceAccountAdmin`
- `roles/iam.serviceAccountUser`
- `roles/iam.workloadIdentityPoolAdmin`

---

## References

- [google_artifact_registry_repository](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/artifact_registry_repository)
- [API documentation](https://cloud.google.com/artifact-registry/docs/reference/rest/v1/projects.locations.repositories)
- [How-to Guides](https://cloud.google.com/artifact-registry/docs/overview)
