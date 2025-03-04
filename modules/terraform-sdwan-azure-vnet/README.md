# Terraform SD-WAN VNET module

Module for creating a VNET in Azure, designed specifically for deploying C8000v in SD-WAN mode.

## Create Azure VNET

Create your VNET to host C8000v instances using the `terraform-sdwan-azure-vnet` module:

```hcl
provider "azurerm" {
  features {}
  subscription_id = [YOUR_SUBSCRIPTION_ID]
}

module "my_vnet" {
  source = "app.terraform.io/jbarozet/terraform-sdwan-c8000v//modules/terraform-sdwan-azure-vnet"

  name                    = sdwanlab
  location                = francecentral
  address_space           = 10.1.0.0/16
  subnet_transport_prefix = 10.1.11.0/24
  subnet_service_prefix   = 10.1.12.0/24
}
```
