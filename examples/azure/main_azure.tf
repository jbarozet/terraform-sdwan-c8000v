# AZURE DEPLOYMENT

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

# VNET DEFINITIONS

module "my_vnet" {
  source = "../../modules/terraform-sdwan-azure-vnet"

  name                    = var.name
  location                = var.location
  address_space           = var.address_space
  subnet_transport_prefix = var.subnet_transport_prefix
  subnet_service_prefix   = var.subnet_service_prefix
}

# C8000v DEPLOYMENT IN AZURE

module "c8000v_azure" {
  source = "../../modules/terraform-sdwan-azure-c8000v"

  # SD-WAN Overlay Parameters
  name              = var.name
  organization_name = var.organization_name
  vbond             = var.vbond
  vbond_port        = var.vbond_port

  # Azure Parameters
  vm_size         = var.vm_size
  image_offer     = var.image_offer
  image_sku       = var.image_sku
  image_publisher = var.image_publisher
  image_version   = var.image_version
  site_id         = var.site_id

  # VNET parameters: outputs from vnet module
  resource_group_name         = module.my_vnet.resource_group_name
  resource_group_location     = module.my_vnet.resource_group_location
  security_group_transport_id = module.my_vnet.security_group_transport_id
  security_group_service_id   = module.my_vnet.security_group_service_id
  subnet_transport_id         = module.my_vnet.subnet_transport_id
  subnet_service_id           = module.my_vnet.subnet_service_id

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
