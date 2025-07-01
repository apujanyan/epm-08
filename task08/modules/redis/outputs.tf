output "redis_id" {
  description = "ID of the Redis Cache"
  value       = azurerm_redis_cache.this.id
}

output "redis_hostname" {
  description = "Hostname of the Redis Cache"
  value       = azurerm_redis_cache.this.hostname
}

output "redis_port" {
  description = "SSL port of the Redis Cache"
  value       = azurerm_redis_cache.this.ssl_port
}

output "redis_hostname_secret_value" {
  description = "Redis hostname secret value"
  value       = azurerm_key_vault_secret.redis_hostname.value
  sensitive   = true
}

output "redis_primary_key_secret_value" {
  description = "Redis primary key secret value"
  value       = azurerm_key_vault_secret.redis_primary_key.value
  sensitive   = true
}