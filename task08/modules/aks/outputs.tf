output "aks_id" {
  description = "ID of the AKS cluster"
  value       = azurerm_kubernetes_cluster.this.id
}

output "kube_config" {
  description = "Kubernetes configuration"
  value       = azurerm_kubernetes_cluster.this.kube_config
  sensitive   = true
}

output "kubelet_identity_object_id" {
  description = "Object ID of the kubelet identity"
  value       = azurerm_kubernetes_cluster.this.kubelet_identity[0].object_id
}

output "cluster_identity_principal_id" {
  description = "Principal ID of the cluster identity"
  value       = azurerm_kubernetes_cluster.this.identity[0].principal_id
}