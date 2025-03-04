# VARIABLES

variable "name" {
  description = "Name"
  type        = string
}

# SD-WAN Overlay

variable "organization_name" {
  description = "organization Name"
  type        = string
}

variable "vbond" {
  description = "vbond ip address"
  type        = string
}

variable "vbond_port" {
  description = "vbond port"
  type        = string
}

# Azure parameters

variable "vm_size" {
  description = "azure vm size"
  type        = string
}

variable "image_offer" {
  description = "azure vm size"
  type        = string
}

variable "image_sku" {
  description = "azure vm size"
  type        = string
}

variable "image_publisher" {
  description = "azure vm size"
  type        = string
}

variable "image_version" {
  description = "azure vm size"
  type        = string
}

# From module VNET

variable "subnet_transport_id" {
  description = "subnet transport id"
  type        = string
}

variable "subnet_service_id" {
  description = "subnet service id"
  type        = string
}

variable "security_group_transport_id" {
  description = "security group transport id"
  type        = string
}

variable "security_group_service_id" {
  description = "security group service id"
  type        = string
}

variable "resource_group_location" {
  description = "resource group location"
  type        = string
}

variable "resource_group_name" {
  description = "resource group name"
  type        = string
}


# C8000 VARIABLES

variable "hostname" {
  description = "c8000v hostname"
  type        = string
}

variable "uuid" {
  description = "c8000v uuid"
  type        = string
}

variable "otp" {
  description = "c8000v otp"
  type        = string
}

variable "site_id" {
  description = "site id"
  type        = string
}

variable "system_ip" {
  description = "system ip address"
  type        = string
}

variable "transport_ip" {
  description = "c8000v transport ip"
  type        = string
}

variable "service_ip" {
  description = "c8000v service ip"
  type        = string
}

variable "username" {
  description = "c8000v username"
  type        = string
}

variable "password" {
  description = "c8000v password"
  type        = string
}
