# AZURE DEPLOYMENT

provider "azurerm" {
  features {}
  subscription_id = local.config.azure.subscription_id
}

# VNET DEFINITIONS

module "my_vnet" {
  # source = "../../modules/azure/vnet"
  source = "../modules/terraform-sdwan-azure-vnet"
  # source = "github.com/jbarozet/terraform-sdwan-c8000v//modules/terraform-sdwan-azure-vnet"

  name                    = local.config.name
  location                = local.config.azure.location
  address_space           = local.config.azure.address_space
  subnet_transport_prefix = local.config.azure.subnet_transport_prefix
  subnet_service_prefix   = local.config.azure.subnet_service_prefix
}

# C8000v DEPLOYMENT IN AZURE

module "c8000v_azure" {
  source = "../modules/terraform-sdwan-azure-c8000v"
  # source = "github.com/jbarozet/terraform-sdwan-c8000v//modules/terraform-sdwan-azure-c8000v"

  for_each = { for instance in local.config.azure.edge_instances : instance.hostname => instance }

  # SD-WAN Overlay Parameters
  name              = local.config.name
  organization_name = local.config.overlay.organization_name
  vbond             = local.config.overlay.vbond
  vbond_port        = local.config.overlay.vbond_port

  # Azure Parameters
  vm_size         = local.config.azure.vm_size
  image_offer     = local.config.azure.image_offer
  image_sku       = local.config.azure.image_sku
  image_publisher = local.config.azure.image_publisher
  image_version   = local.config.azure.image_version
  site_id         = local.config.aws.site_id

  # VNET parameters: outputs from vnet module
  resource_group_name         = module.my_vnet.resource_group_name
  resource_group_location     = module.my_vnet.resource_group_location
  security_group_transport_id = module.my_vnet.security_group_transport_id
  security_group_service_id   = module.my_vnet.security_group_service_id
  subnet_transport_id         = module.my_vnet.subnet_transport_id
  subnet_service_id           = module.my_vnet.subnet_service_id

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
