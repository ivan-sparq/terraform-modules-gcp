locals {
  url_map = {
    "PYTHON" : "https://${var.region}-python.pkg.dev/${var.project_id}/${var.name}",
    "DOCKER" : "${var.region}-docker.pkg.dev/${var.project_id}/${var.name}"
  }
}
output "name" {
  value = var.name
}

output "url" {
  value = lookup(local.url_map, var.format, null)
}
