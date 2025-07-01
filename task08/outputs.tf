output "aci_fqdn" {
  description = "FQDN of App in Azure Container Instance"
  value       = module.aci.aci_fqdn
}

output "acr_login_server" {
  description = "ACR login server"
  value       = module.acr.acr_login_server
}