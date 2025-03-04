# VARIABLES

variable "name" {
  description = "Name"
  type        = string
}

# Azure Parameters

variable "location" {
  description = "azure location"
  type        = string
}

variable "address_space" {
  description = "vpc address space"
  type        = string
}

variable "subnet_transport_prefix" {
  description = "vpc transport subnet address space"
  type        = string
}

variable "subnet_service_prefix" {
  description = "vpc service subnet address space"
  type        = string
}
