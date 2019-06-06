output "service_name" {
  value       = "${kubernetes_service.service.metadata.0.name}"
  description = "The name of the proxy service, which other pods use to connect to the proxy."
}
