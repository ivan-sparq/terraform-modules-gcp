variable "project_id" {
  description = "Google Cloud Platform Project"
  type        = string
}


variable "region" {
  description = "Region to use e.g. `europe-west4`. Region must support Cloud Run, see https://cloud.google.com/run/docs/locations"
  type        = string
}

variable "roles" {
  description = "Extra roles to be given to CloudBuild"
  type        = set(string)
  default     = []
}

variable "env" {
  description = "Name of env / TF workspace"
  type        = string
}

variable "sa_name" {
  description = "The name of the service account to create"
  type        = string
  default     = "sa-cloudbuild"
}

variable "github_owner" {
  description = "Name github org the repo belongs to"
  type        = string
}

variable "github_repo" {
  description = "Name github repo to create a trigger for"
  type        = string
}

variable "github_branch" {
  description = "Create Terraform triggers"
  type        = string
}

variable "github_connection_name" {
  description = "The name of the GitHub connection"
  type        = string
}


variable "enable_tf_triggers" {
  description = "Create Terraform triggers when creating a PR to `branch` and when merging to `branch`"
  type        = bool
  default     = false
}

variable "notification_channels" {
  description = "List of notification channels to send alerts to"
  type        = list(string)
  default     = []
}

variable "config_dir" {
  description = "Directory of cloudbuild file"
  type        = string
}

variable "enable_gha_auth" {
  description = "authenticate GitHub Actions with GCP using Workload Identity Federation"
  type        = bool
  default     = false
}
