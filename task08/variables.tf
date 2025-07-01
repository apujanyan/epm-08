variable "name_prefix" {
  description = "Name prefix for resources."
  type        = string
}

variable "location" {
  description = "Location for resources."
  type        = string
}

variable "redis_capacity" {
  description = "Redis capacity."
  type        = number
}

variable "redis_sku" {
  description = "Redis SKU."
  type        = string
}

variable "redis_sku_family" {
  description = "Redis SKU family."
  type        = string
}

variable "keyvault_sku" {
  description = "Keyvaul SKU."
  type        = string
}

variable "redis_hostname" {
  description = "Redis hostname secret name."
  type        = string
}

variable "redis_primary_key" {
  description = "Redis primary key secret name."
  type        = string
}

variable "acr_sku" {
  description = "ACR SKU."
  type        = string
}

variable "aci_sku" {
  description = "ACI SKU."
  type        = string
}

variable "git_pat" {
  sensitive   = true
  description = "Git pat."
  type        = string
}

variable "tags" {
  description = "Tags for resources."
  type        = map(string)
}