# AWS DEPLOYMENT

provider "aws" {
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "default"
  region                   = local.config.aws.cloud_region
}

# VPC DEFINITIONS

module "my_vpc" {
  source = "./modules/terraform-sdwan-aws-vpc"

  name                    = local.config.name
  availability_zone       = local.config.aws.availability_zone
  address_space           = local.config.aws.address_space
  subnet_transport_prefix = local.config.aws.subnet_transport_prefix
  subnet_service_prefix   = local.config.aws.subnet_service_prefix

}

# C8000v DEPLOYMENT IN AWS

module "c8000v_aws" {
  source = "./modules/terraform-sdwan-aws-c8000v"

  for_each = { for instance in local.config.aws.edge_instances : instance.hostname => instance }

  # SD-WAN Overlay Parameters
  name              = local.config.name
  organization_name = local.config.overlay.organization_name
  vbond             = local.config.overlay.vbond
  vbond_port        = local.config.overlay.vbond_port

  # AWS Parameters
  cloud_region      = local.config.aws.cloud_region
  availability_zone = local.config.aws.availability_zone
  image_id          = local.config.aws.image_id
  instance_type     = local.config.aws.instance_type
  site_id           = local.config.aws.site_id

  # VPC parameters: outputs from vpc module
  subnet_transport_id         = module.my_vpc.subnet_transport_id
  subnet_service_id           = module.my_vpc.subnet_service_id
  security_group_transport_id = module.my_vpc.security_group_transport_id
  security_group_service_id   = module.my_vpc.security_group_service_id

  # C8000v parameters
  hostname     = each.value.hostname
  uuid         = each.value.uuid
  otp          = each.value.otp
  system_ip    = each.value.system_ip
  transport_ip = each.value.transport_ip
  service_ip   = each.value.service_ip
  username     = each.value.admin_username
  password     = each.value.admin_password

}
