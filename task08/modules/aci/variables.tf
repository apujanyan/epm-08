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

variable "acr_login_server" {
  description = "ACR login server"
  type        = string
}

variable "acr_username" {
  description = "ACR admin username"
  type        = string
}

variable "acr_password" {
  description = "ACR admin password"
  type        = string
  sensitive   = true
}

variable "docker_image_name" {
  description = "Name of the Docker image"
  type        = string
}

variable "redis_hostname" {
  description = "Redis hostname"
  type        = string
  sensitive   = true
}

variable "redis_primary_key" {
  description = "Redis primary key"
  type        = string
  sensitive   = true
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}