# VARIABLES

variable "name" {
  description = "Name used as a prefix to tag aws resources"
  type        = string
}

# AWS Parameters

variable "availability_zone" {
  description = "aws availability zone"
  type        = string
}

variable "address_space" {
  description = "aws address space"
  type        = string
}

variable "subnet_transport_prefix" {
  description = "Catalyst SD-WAN Transport subnet address space"
  type        = string
}

variable "subnet_service_prefix" {
  description = "Catalyst SD-WAN Service subnet address space"
  type        = string
}
