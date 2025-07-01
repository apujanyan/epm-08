data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "rg" {
  name = local.rg_name
  location = var.location

  tags = var.tags
}

module "acr" {
  source = "./modules/acr"
  name = local.acr_name
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku = var.acr_sku
  git_pat = var.git_pat
  docker_image_name = local.docker_image_name

  tags = var.tags
}

module "keyvault" {
  source = "./modules/keyvault"
  name = local.keyvault_name
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azurerm_client_config.current.object_id

  tags = var.tags
}

module "redis" {
  source = "./modules/redis"
  name = local.redis_name
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  capacity = var.redis_capacity
  sku_name = var.redis_sku
  family = var.redis_sku_family
  redis_hostname_secret_name = var.redis_hostname
  redis_primary_key_secret_name = var.redis_primary_key
  key_vault_id = module.keyvault.key_vault_id

  tags = var.tags

  depends_on = [module.keyvault]
}

module "aci" {
  source = "./modules/aci"
  name = local.aci_name
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  acr_login_server = module.acr.acr_login_server
  acr_username = module.acr.acr_admin_username
  acr_password = module.acr.acr_admin_password
  docker_image_name = local.docker_image_name
  redis_hostname = module.redis.redis_hostname_secret_value
  redis_primary_key = module.redis.redis_primary_key_secret_value
  
  tags = var.tags
}