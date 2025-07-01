output "acr_id" {
  description = "ID of the Container Registry"
  value       = azurerm_container_registry.this.id
}

output "acr_login_server" {
  description = "Login server of the Container Registry"
  value       = azurerm_container_registry.this.login_server
}

output "acr_admin_username" {
  description = "Admin username of the Container Registry"
  value       = azurerm_container_registry.this.admin_username
}

output "acr_admin_password" {
  description = "Admin password of the Container Registry"
  value       = azurerm_container_registry.this.admin_password
  sensitive   = true
}