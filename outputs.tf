output "website_url" {
  value = "http://${google_compute_global_forwarding_rule.http_rule.ip_address}"
}
