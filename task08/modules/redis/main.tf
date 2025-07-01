resource "azurerm_redis_cache" "this" {
  name = var.name
  location = var.location
  resource_group_name = var.resource_group_name
  capacity = var.capacity
  sku_name = var.sku_name
  family = var.family
  minimum_tls_version = "1.2"

  tags = var.tags
}

resource "azurerm_key_vault_secret" "redis_hostname" {
  name = var.redis_hostname_secret_name
  value = azurerm_redis_cache.this.hostname
  key_vault_id = var.key_vault_id

  depends_on = [azurerm_redis_cache.this]
}

resource "azurerm_key_vault_secret" "redis_primary_key" {
  name = var.redis_primary_key_secret_name
  value = azurerm_redis_cache.this.primary_access_key
  key_vault_id = var.key_vault_id

  depends_on = [azurerm_redis_cache.this]
}