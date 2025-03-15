variable "project_id" {
  type        = string
  description = "The GCP project id"
}

variable "admin_service_account" {
  type        = string
  description = "The service account that will provision the resources and will be given admin access to the artifact registry"
}

variable "region" {
  type        = string
  description = "The GCP region"
}

variable "name" {
  type        = string
  description = "The name of the repository"
}

variable "format" {
  type        = string
  description = "The format of the repository. One of PYTHON or DOCKER"
  default     = "PYTHON"
}

variable "sa_read" {
  type        = list(string)
  description = "List of service accounts with read access. (email addresses)"
  default     = []
}

variable "sa_write" {
  type        = list(string)
  description = "List of service accounts with write access. (email addresses)"
  default     = []
}

variable "docker_immutable_tags" {
  description = "Prevents all tags from being modified, moved or deleted. This does not prevent tags from being created."
  type        = bool
  default     = false
}

variable "docker_delete_untagged" {
  description = "Whether to enable cleanup policy to delete untagged images"
  type        = bool
  default     = false
}
