name_prefix       = "cmtr-d4qm9uvw-mod8"
location          = "northeurope"
redis_capacity    = 2
redis_sku         = "Basic"
redis_sku_family  = "C"
keyvault_sku      = "standard"
redis_hostname    = "redis-hostname"
redis_primary_key = "redis-primary-key"
acr_sku           = "Standard"
aci_sku           = "Standard"
default_node_pool_name = "system"
default_node_pool_instance_count = 1
default_node_pool_instance_node_size = "Standard_D2ads_v5"
default_node_pool_os_type = "Ephemeral"
tags = {
  Creator = "aramazd_apujanyan@epam.com"
}