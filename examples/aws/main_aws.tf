# AWS DEPLOYMENT

provider "aws" {
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "default"
  region                   = var.cloud_region
}

# VPC DEFINITIONS

module "my_vpc" {
  source = "../../modules/terraform-sdwan-aws-vpc"

  name                    = var.name
  availability_zone       = var.availability_zone
  address_space           = var.address_space
  subnet_transport_prefix = var.subnet_transport_prefix
  subnet_service_prefix   = var.subnet_service_prefix

}

# C8000v DEPLOYMENT IN AWS

module "c8000v_aws" {
  source = "../../modules/terraform-sdwan-aws-c8000v"

  # SD-WAN Overlay Parameters
  name              = var.name
  organization_name = var.organization_name
  vbond             = var.vbond
  vbond_port        = var.vbond_port

  # AWS Parameters
  cloud_region      = var.cloud_region
  availability_zone = var.availability_zone
  image_id          = var.image_id
  instance_type     = var.instance_type
  site_id           = var.site_id

  # VPC parameters: outputs from vpc module
  subnet_transport_id         = module.my_vpc.subnet_transport_id
  subnet_service_id           = module.my_vpc.subnet_service_id
  security_group_transport_id = module.my_vpc.security_group_transport_id
  security_group_service_id   = module.my_vpc.security_group_service_id

  # C8000v parameters
  hostname     = var.hostname
  uuid         = var.uuid
  otp          = var.otp
  system_ip    = var.system_ip
  transport_ip = var.transport_ip
  service_ip   = var.service_ip
  username     = var.admin_username
  password     = var.admin_password

}
