variable "name" {
  description = "Name of the Key Vault"
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

variable "tenant_id" {
  description = "Azure tenant ID"
  type        = string
}

variable "object_id" {
  description = "Object ID for access policy"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}