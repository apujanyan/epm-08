variable "name" {
  description = "Name of the Redis Cache"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "capacity" {
  description = "Redis capacity."
  type        = number
}

variable "sku_name" {
  description = "Redis SKU."
  type        = string
}

variable "family" {
  description = "Redis SKU family."
  type        = string
}

variable "redis_hostname_secret_name" {
  description = "Redis hostname."
  type = string
}

variable "redis_primary_key_secret_name" {
  description = "Redis primary key."
  type = string
}

variable "key_vault_id" {
  description = "ID of the Key Vault"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}