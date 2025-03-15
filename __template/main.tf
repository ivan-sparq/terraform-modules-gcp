data "google_project" "default" {
  project_id = var.project_id
}


resource "google_project_service" "default" {
  for_each = toset([

  ])
  service            = each.key
  project            = var.project_id
  disable_on_destroy = false
}

