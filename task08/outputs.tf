output "aci_fqdn" {
  description = "FQDN of App in Azure Container Instance"
  value       = module.aci.aci_fqdn
}

output "aks_lb_ip" {
  description = "Load Balancer IP address of the app in AKS"
  value = try(
    data.kubernetes_service.app_service.status[0].load_balancer[0].ingress[0].ip,
    "pending"
  )
}