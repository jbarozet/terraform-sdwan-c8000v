# Terraform SD-WAN C8000v in Azure module

Module to deploy C8000v instances in Azure.

## Create Azure VNET

Create your VNET to host C8000v instances using the `terraform-sdwan-azure-vnet` module:

```hcl
provider "azurerm" {
  features {}
  subscription_id = [YOUR_SUBSCRIPTION_ID]
}

module "my_vnet" {
  source = "jbarozet/c8000v/sdwan//modules/terraform-sdwan-azure-vnet"

  name                    = sdwanlab
  location                = francecentral
  address_space           = 10.1.0.0/16
  subnet_transport_prefix = 10.1.11.0/24
  subnet_service_prefix   = 10.1.12.0/24
}
```

## Deploy C8000v instances in Azure

Then deploy C8000v instances.
Deploy as many instances as you need. They will be instantiated in the same VNET.

```hcl
module "c8000v_3" {
  source = "jbarozet/c8000v/sdwan//modules/terraform-sdwan-azure-c8000v"

  # SD-WAN Overlay Parameters
  name              = sdwanlab
  organization_name = [ORG_NAME]
  vbond             = 192.168.3.1
  vbond_port        = 12346

  # Azure Parameters
  vm_size         = Standard_D2_v2
  image_offer     = cisco-c8000v-byol
  image_sku       = 17_14_01a-byol
  image_publisher = cisco
  image_version   = latest
  site_id         = 1002

  # VNET parameters: outputs from vnet module
  resource_group_name         = module.my_vnet.resource_group_name
  resource_group_location     = module.my_vnet.resource_group_location
  security_group_transport_id = module.my_vnet.security_group_transport_id
  security_group_service_id   = module.my_vnet.security_group_service_id
  subnet_transport_id         = module.my_vnet.subnet_transport_id
  subnet_service_id           = module.my_vnet.subnet_service_id

  # C8000v parameters
  hostname     = edge-3
  uuid         = [C8K-XXXX-XXXX-XXXX-XXXX]
  otp          = [xxxxxxxxxxxx]
  system_ip    = 192.168.103.1
  transport_ip =  10.1.11.103
  service_ip   = 10.1.12.103
  username     = [USERNAME]
  password     = [PASSWORD]

}
```
