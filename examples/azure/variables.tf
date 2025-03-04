# VARIABLES

# -----------------------------------------------------------------------------
# Global
# -----------------------------------------------------------------------------

variable "name" {
  description = "Base name used for resource naming"
  type        = string
  default     = "sdwanlab"
}

# -----------------------------------------------------------------------------
# Controllers
# -----------------------------------------------------------------------------

variable "organization_name" {
  description = "SD-WAN organization name"
  type        = string
  default     = "org-name"
}

variable "vbond" {
  description = "vBond controller IP address"
  type        = string
  default     = "10.0.0.1"
}

variable "vbond_port" {
  description = "vBond controller port"
  type        = number
  default     = 12346
}

# -----------------------------------------------------------------------------
# Azure deployment
# -----------------------------------------------------------------------------

variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
  sensitive   = true
}

variable "cloud_region" {
  description = "Azure cloud region"
  type        = string
  default     = "westeurope"
}

variable "location" {
  description = "Azure location for resources"
  type        = string
  default     = "francecentral"
}

variable "address_space" {
  description = "VNet address space CIDR"
  type        = string
  default     = "10.1.0.0/16"
}

variable "subnet_transport_prefix" {
  description = "CIDR for transport subnet"
  type        = string
  default     = "10.1.11.0/24"
}

variable "subnet_service_prefix" {
  description = "CIDR for service subnet"
  type        = string
  default     = "10.1.12.0/24"
}

variable "image_publisher" {
  description = "Azure image publisher"
  type        = string
  default     = "cisco"
}

variable "image_offer" {
  description = "Azure image offer"
  type        = string
  default     = "cisco-c8000v-byol"
}

variable "image_sku" {
  description = "Azure image SKU"
  type        = string
  default     = "17_14_01a-byol"
}

variable "image_version" {
  description = "Azure image version"
  type        = string
  default     = "latest"
}

variable "vm_size" {
  description = "Azure VM size"
  type        = string
  default     = "Standard_D2_v2"
}

variable "image_id" {
  description = "Azure image ID"
  type        = string
  default     = "cisco-c8000v-byol"
}

# -----------------------------------------------------------------------------
# C8000v
# -----------------------------------------------------------------------------

variable "site_id" {
  description = "SD-WAN site ID"
  type        = number
  default     = 1002
}

variable "hostname" {
  description = "Hostname for the device"
  type        = string
  default     = "edge-3"
}

variable "uuid" {
  description = "Device UUID"
  type        = string
}

variable "otp" {
  description = "One-time password for device activation"
  type        = string
}

variable "system_ip" {
  description = "System IP for SD-WAN device"
  type        = string
  default     = "192.168.103.1"
}

variable "transport_ip" {
  description = "Transport interface IP address"
  type        = string
  default     = "10.1.11.103"
}

variable "service_ip" {
  description = "Service interface IP address"
  type        = string
  default     = "10.1.12.103"
}

variable "admin_username" {
  description = "Admin username for the device"
  type        = string
  default     = "admin"
}

variable "admin_password" {
  description = "Admin password for the device"
  type        = string
  default     = "mysupersecurepassword"
  sensitive   = true
}
