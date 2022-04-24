output "region" {
  value       = var.region
  description = "GCloud Region"
}

output "project_id" {
  value       = var.project_id
  description = "GCloud Project ID"
}

output "kubernetes_cluster_name" {
  value       = google_container_cluster.mobiel.name
  description = "GKE Cluster Name"
}

output "kubernetes_cluster_host" {
  value       = google_container_cluster.mobiel.endpoint
  description = "GKE Cluster Host"
}

#output "load_balancer_ip" {
#  value = kubernetes_service.nginx.status.0.load_balancer.0.ingress.0.ip
#}