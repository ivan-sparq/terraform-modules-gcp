# Terraform Google XXXXXX Module

This module makes it easy to create and manage xxxxxx

## Compatibility

This module is compatible with Terraform 1.5 and above.
And it has been tested with OpenTofu 1.9

## Usage

```hcl
module "xxx" {
  source    = "github.com/ivan-sparq/terraform-modules-gcp//xxxxx"
  project_id   = "my-project-id"
  region    = "europe-west2"
  name      = "my-xxx"
}
```

Functional examples are included in the [examples](./examples) directory.

## Input Variables

| Name         | Type   | Description            |
| ------------ | ------ | ---------------------- |
| `name`       | string | Name of the repository |
| `project_id` | string | GCP Project ID         |
| `region`     | string | GCP Region             |

## Outputs

| Name  | Description |
| ----- | ----------- |
| `foo` | The foo     |

## Requirements

### Service Account

User or service account credentials with the following roles must be used to provision the resources of this module:

- `roles/iam.roleViewer`
- `roles/iam.serviceAccountAdmin`
- `roles/iam.serviceAccountUser`
- `roles/iam.workloadIdentityPoolAdmin`

---

## References
