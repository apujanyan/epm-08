terraform {
  required_version = ">= 1.5.7"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.110.0, < 4.0.0"
    }
    kubectl = {
      source  = "alekc/kubectl"
      version = "~> 2.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

# provider "kubectl" {
#   host                   = module.aks.kube_config[0].host
#   client_certificate     = base64decode(module.aks.kube_config[0].client_certificate)
#   client_key             = base64decode(module.aks.kube_config[0].client_key)
#   cluster_ca_certificate = base64decode(module.aks.kube_config[0].cluster_ca_certificate)
# }

# provider "kubernetes" {
#   host                   = module.aks.kube_config[0].host
#   client_certificate     = base64decode(module.aks.kube_config[0].client_certificate)
#   client_key             = base64decode(module.aks.kube_config[0].client_key)
#   cluster_ca_certificate = base64decode(module.aks.kube_config[0].cluster_ca_certificate)
# }