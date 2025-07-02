locals {
  rg_name           = join("-", [var.name_prefix, "rg"])
  redis_name        = join("-", [var.name_prefix, "redis"])
  keyvault_name     = join("-", [var.name_prefix, "kv"])
  aci_name          = join("-", [var.name_prefix, "ci"])
  aks_name          = join("-", [var.name_prefix, "aks"])
  docker_image_name = join("-", [var.name_prefix, "app"])
  acr_name          = replace("${var.name_prefix}cr", "-", "")
}