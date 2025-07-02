resource "azurerm_kubernetes_cluster" "this" {
  name = var.name
  location = var.location
  resource_group_name = var.resource_group_name
  dns_prefix = var.name

  default_node_pool {
    name = var.default_node_pool_name
    node_count = var.default_node_pool_instance_count
    vm_size = var.default_node_pool_instance_node_size
    os_disk_type = var.default_node_pool_os_type
    type       = "VirtualMachineScaleSets"
  }

  identity {
    type = "SystemAssigned"
  }

  key_vault_secrets_provider {
    secret_rotation_enabled = true
  }

  tags = var.tags
}

resource "azurerm_role_assignment" "acr_pull" {
  principal_id = azurerm_kubernetes_cluster.this.identity[0].principal_id
  role_definition_name = "AcrPull"
  scope = var.acr_id
}

resource "azurerm_key_vault_access_policy" "aks_access" {
  key_vault_id = var.key_vault_id
  tenant_id = azurerm_kubernetes_cluster.this.kubelet_identity[0].tenant_id
  object_id = azurerm_kubernetes_cluster.this.kubelet_identity[0].object_id

  secret_permissions = ["Get"]
}