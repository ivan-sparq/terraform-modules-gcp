variable "project_id" {
  description = "Google Cloud Platform Project"
  type        = string
}

variable "region" {
  description = "Region to use e.g. `europe-west4`"
  type        = string
}

variable "github_owner" {
  description = "Name github org the repo belongs to"
  type        = string
}

variable "github_app_installation_id" {
  description = "The installation ID of the GitHub App used for second-generation repository connection"
  type        = number
}

variable "github_token_secret_id" {
  description = "The Secret Manager id of the GitHub token used for authentication (format: projects/*/secrets/*)"
  type        = string
}

variable "github_token_secret_version" {
  description = "The Secret Manager version of the GitHub token used for authentication (format: projects/*/secrets/*/versions/*)"
  type        = string
}

