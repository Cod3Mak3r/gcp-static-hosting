provider "google" {
  project = var.project_id
  region  = "us-central1"
}

resource "google_storage_bucket" "static_site" {
  name     = var.bucket_name
  location = "US"
  uniform_bucket_level_access = true

  website {
    main_page_suffix = "index.html"
    not_found_page   = "index.html"
  }
}

resource "google_storage_bucket_iam_binding" "public_access" {
  bucket = google_storage_bucket.static_site.name
  role   = "roles/storage.objectViewer"

  members = [
    "allUsers",
  ]
}

resource "google_storage_bucket_object" "website_index" {
  name   = "index.html"
  bucket = google_storage_bucket.static_site.name
  source = "index.html"
  content_type = "text/html"
}

resource "google_compute_backend_bucket" "cdn_backend" {
  name        = "cdn-backend"
  bucket_name = google_storage_bucket.static_site.name
  enable_cdn  = true
}

resource "google_compute_url_map" "website_map" {
  name = "website-map"

  default_service = google_compute_backend_bucket.cdn_backend.self_link
}

resource "google_compute_target_http_proxy" "http_proxy" {
  name    = "http-proxy"
  url_map = google_compute_url_map.website_map.self_link
}

resource "google_compute_global_forwarding_rule" "http_rule" {
  name       = "http-rule"
  target     = google_compute_target_http_proxy.http_proxy.self_link
  port_range = "80"
}
