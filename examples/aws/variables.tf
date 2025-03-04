# VARIABLES

# -----------------------------------------------------------------------------
# Global
# -----------------------------------------------------------------------------

variable "name" {
  description = "Base name used for resources"
  type        = string
  default     = "sdwanlab"
}

# -----------------------------------------------------------------------------
# Controllers
# -----------------------------------------------------------------------------

variable "organization_name" {
  description = "SD-WAN overlay organization name"
  type        = string
  default     = "org-name"
}

variable "vbond" {
  description = "SD-WAN vBond controller IP address"
  type        = string
  default     = "10.1.1.1"
}

variable "vbond_port" {
  description = "SD-WAN vBond controller port"
  type        = number
  default     = 12346
}

# -----------------------------------------------------------------------------
# AWS
# -----------------------------------------------------------------------------

variable "cloud_region" {
  description = "AWS region for deploying resources"
  type        = string
  default     = "eu-west-3"
}

variable "availability_zone" {
  description = "AWS availability zone within the region"
  type        = string
  default     = "eu-west-3a"
}

variable "address_space" {
  description = "VPC address space CIDR"
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

variable "image_id" {
  description = "AMI ID for the Cisco SD-WAN instance"
  type        = string
  default     = "ami-0af4ffee3c664012e"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "c5n.large"
}

# -----------------------------------------------------------------------------
# C8000v
# -----------------------------------------------------------------------------

variable "site_id" {
  description = "Site identifier"
  type        = number
  default     = 1001
}

variable "hostname" {
  description = "Hostname for the SD-WAN edge device"
  type        = string
  default     = "edge-1"
}

variable "uuid" {
  description = "UUID for the SD-WAN edge device (from SD-WAN Manager device list)"
  type        = string
}

variable "otp" {
  description = "One-time password for device activation (from SD-WAN Manager device list)"
  type        = string
}

variable "system_ip" {
  description = "System IP address for the SD-WAN device"
  type        = string
  default     = "192.168.101.1"
}

variable "transport_ip" {
  description = "Transport interface IP address"
  type        = string
  default     = "10.1.11.101"
}

variable "service_ip" {
  description = "Service interface IP address"
  type        = string
  default     = "10.1.12.101"
}

variable "admin_username" {
  description = "Admin username for the SD-WAN device"
  type        = string
  default     = "admin"
}

variable "admin_password" {
  description = "Admin password for the SD-WAN device"
  type        = string
  default     = "mysupersecurepassword#"
  sensitive   = true
}
