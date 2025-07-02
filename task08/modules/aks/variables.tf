variable "name" {
  description = "Name of the Container Instance"
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

variable "default_node_pool_name" {
  description = "Default node pool name."
  type = string
}

variable "default_node_pool_instance_count" {
  description = "Default node pool instance count."
  type = number
}

variable "default_node_pool_instance_node_size" {
  description = "Default node pool instance node size."
  type = string
}

variable "default_node_pool_os_type" {
  description = "Default node pool os type."
  type = string
}

variable "acr_id" {
  description = "ACR ID."
  type        = string
}

variable "key_vault_id" {
  description = "Key Vault ID."
  type        = string
}

variable "tags" {
  description = "Tags for resources."
  type        = map(string)
}