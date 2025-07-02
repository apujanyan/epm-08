data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "rg" {
  name     = local.rg_name
  location = var.location

  tags = var.tags
}

module "acr" {
  source              = "./modules/acr"
  name                = local.acr_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = var.acr_sku
  git_pat             = var.git_pat
  docker_image_name   = local.docker_image_name

  tags = var.tags
}

module "aks" {
  source                               = "./modules/aks"
  name                                 = local.aks_name
  location                             = azurerm_resource_group.rg.location
  resource_group_name                  = azurerm_resource_group.rg.name
  default_node_pool_name               = var.default_node_pool_name
  default_node_pool_instance_count     = var.default_node_pool_instance_count
  default_node_pool_instance_node_size = var.default_node_pool_instance_node_size
  default_node_pool_os_type            = var.default_node_pool_os_type
  acr_id                               = module.acr.acr_id
  key_vault_id                         = module.keyvault.key_vault_id

  tags = var.tags
}

module "keyvault" {
  source              = "./modules/keyvault"
  name                = local.keyvault_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  object_id           = data.azurerm_client_config.current.object_id

  tags = var.tags
}

module "redis" {
  source                        = "./modules/redis"
  name                          = local.redis_name
  location                      = azurerm_resource_group.rg.location
  resource_group_name           = azurerm_resource_group.rg.name
  capacity                      = var.redis_capacity
  sku_name                      = var.redis_sku
  family                        = var.redis_sku_family
  redis_hostname_secret_name    = var.redis_hostname
  redis_primary_key_secret_name = var.redis_primary_key
  key_vault_id                  = module.keyvault.key_vault_id

  tags = var.tags

  depends_on = [module.keyvault]
}

module "aci" {
  source              = "./modules/aci"
  name                = local.aci_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  acr_login_server    = module.acr.acr_login_server
  acr_username        = module.acr.acr_admin_username
  acr_password        = module.acr.acr_admin_password
  docker_image_name   = local.docker_image_name
  redis_hostname      = module.redis.redis_hostname_secret_value
  redis_primary_key   = module.redis.redis_primary_key_secret_value

  tags = var.tags
}

resource "kubectl_manifest" "secret_provider" {
  yaml_body = templatefile("${path.module}/k8s-manifests/secret-provider.yaml.tftpl", {
    aks_kv_access_identity_id  = module.aks.kubelet_identity_object_id
    kv_name                    = module.keyvault.key_vault_name
    redis_url_secret_name      = module.redis.redis_hostname_secret_value
    redis_password_secret_name = module.redis.redis_primary_key_secret_value
    tenant_id                  = data.azurerm_client_config.current.tenant_id
  })

  depends_on = [module.aks, module.keyvault, module.redis, module.aks, module.acr]
}

resource "kubectl_manifest" "deployment" {
  yaml_body = templatefile("${path.module}/k8s-manifests/deployment.yaml.tftpl", {
    acr_login_server = module.acr.acr_login_server
    app_image_name   = local.docker_image_name
    image_tag        = "latest"
  })

  wait_for {
    field {
      key   = "status.readyReplicas"
      value = "1"
    }
  }

  depends_on = [kubectl_manifest.secret_provider, module.acr, module.aks, module.aks]
}

resource "kubectl_manifest" "service" {
  yaml_body = file("${path.module}/k8s-manifests/service.yaml")

  wait_for {
    field {
      key   = "status.loadBalancer.ingress.0.ip"
      value = "regex:^\\d+\\.\\d+\\.\\d+\\.\\d+$"
    }
  }

  depends_on = [kubectl_manifest.deployment, module.aks, module.acr, module.redis]
}

data "kubernetes_service" "app_service" {
  metadata {
    name = "redis-flask-app-service"
  }

  depends_on = [kubectl_manifest.service]
}

data "azurerm_kubernetes_cluster" "this" {
  name                = module.aks.aks_name
  resource_group_name = azurerm_resource_group.rg.name
}

provider "kubectl" {
  host                   = data.azurerm_kubernetes_cluster.this.kube_config[0].host
  client_certificate     = base64decode(data.azurerm_kubernetes_cluster.this.kube_config[0].client_certificate)
  client_key             = base64decode(data.azurerm_kubernetes_cluster.this.kube_config[0].client_key)
  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.this.kube_config[0].cluster_ca_certificate)
  load_config_file       = false
}

provider "kubernetes" {
  host                   = data.azurerm_kubernetes_cluster.this.kube_config[0].host
  client_certificate     = base64decode(data.azurerm_kubernetes_cluster.this.kube_config[0].client_certificate)
  client_key             = base64decode(data.azurerm_kubernetes_cluster.this.kube_config[0].client_key)
  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.this.kube_config[0].cluster_ca_certificate)
}
