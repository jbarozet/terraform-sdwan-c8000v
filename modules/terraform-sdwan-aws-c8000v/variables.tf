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

# AWS Parameters

variable "cloud_region" {
  description = "name of aws region"
  type        = string
}

variable "availability_zone" {
  description = "aws availability zone"
  type        = string
}

variable "image_id" {
  description = "image ami"
  type        = string
}

variable "instance_type" {
  description = "aws instance type"
  type        = string
}


# From module VPC

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


# C8000v parameters

variable "hostname" {
  description = "hostname"
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
  description = "transport ip address"
  type        = string
}

variable "service_ip" {
  description = "service ip address"
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
