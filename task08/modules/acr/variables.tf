variable "name" {
  description = "ACR name."
  type        = string
}

variable "resource_group_name" {
  description = "ACR rg."
  type        = string
}

variable "location" {
  description = "ACR location."
  type        = string
}

variable "sku" {
  description = "ACR SKU."
  type        = string
}

variable "docker_image_name" {
  description = "Docker image name."
  type        = string
}

variable "git_pat" {
  sensitive   = true
  description = "GIT pat."
  type        = string
}

variable "tags" {
  description = "Tags for resources."
  type        = map(string)
}