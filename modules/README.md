# Terraform SD-WAN C8000v modules

Set of modules to deploy C8000v instances in AWS and Azure.

All parameters are conveniently specified in a YAML file (config.yaml).
Please define the number of C8000v instances you require in the AWS and Azure sections.

## Variables

Read variables from yaml file:

```hcl
variable "config_file" {
  default = "./config.yaml"
}

locals {
  yaml_content = file(var.config_file)
  config       = yamldecode(local.yaml_content)
}
```

## Create AWS VPC

Create your VPC to host C8000v instances using the `terraform-sdwan-aws-vpc` module:

```hcl
provider "aws" {
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "default"
  region                   = local.config.aws.cloud_region
}

# VPC DEFINITIONS

module "my_vpc" {
  source                  = "app.terraform.io/jbarozet/terraform-sdwan-c8000v//modules/terraform-sdwan-aws-vpc"
  name                    = local.config.name
  availability_zone       = local.config.aws.availability_zone
  address_space           = local.config.aws.address_space
  subnet_transport_prefix = local.config.aws.subnet_transport_prefix
  subnet_service_prefix   = local.config.aws.subnet_service_prefix

}
```

## Create Azure VNET

Create your VNET to host C8000v instances using the `terraform-sdwan-azure-vnet` module:

```hcl
module "my_vnet" {
  source                  = "app.terraform.io/jbarozet/terraform-sdwan-c8000v//modules/terraform-sdwan-azure-vnet"

  name                    = local.config.name
  location                = local.config.azure.location
  address_space           = local.config.azure.address_space
  subnet_transport_prefix = local.config.azure.subnet_transport_prefix
  subnet_service_prefix   = local.config.azure.subnet_service_prefix
}
```

# Deploy C8000v instances in AWS

Then deploy C8000v instances using the `terraform-sdwan-aws-c8000v` module.
Create a C8000v resource for each edge instance defined in the AWS section of the configuration file.

```hcl
module "c8000v_aws" {
  source = "app.terraform.io/jbarozet/terraform-sdwan-c8000v//modules/terraform-sdwan-aws-c8000v"

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
```

## Deploy C8000v instances in Azure

Then deploy C8000v instances using the `terraformm-sdwan-azure-c8000v` module.
Create a C8000v resource for each edge instance defined in the Azure section of the configuration file.

```hcl
module "c8000v_azure" {
  source = "app.terraform.io/jbarozet/terraform-sdwan-c8000v//modules/terraform-sdwan-azure-c8000v"

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
```


## Example of YAML configuration file

config.yaml example:

```yaml
# Global
name: sdwanlab

# Controllers
overlay:
  organization_name: <ORG_NAME>
  vbond: 192.168.3.1
  vbond_port: 12346

# AWS configuration
aws:
  cloud_region: eu-west-3
  availability_zone: eu-west-3a
  address_space: 10.1.0.0/16
  subnet_transport_prefix: 10.1.11.0/24
  subnet_service_prefix: 10.1.12.0/24
  image_id: ami-xxxxxxxxxxxx
  instance_type: c5n.large
  site_id: 1001

  edge_instances:
    - hostname: edge-1
      uuid: C8K-XXXX-XXXX-XXXX-XXXX
      otp: xxxxxxxxxxxx
      system_ip: 192.168.101.1
      transport_ip: 10.1.11.101
      service_ip: 10.1.12.101
      admin_username: <USERNAME>
      admin_password: <PASSWORD>
    - hostname: edge-2
      uuid: C8K-YYYY-YYYY-YYYY-YYYY
      otp: yyyyyyyyyyyyy
      system_ip: 192.168.102.1
      transport_ip: 10.1.11.102
      service_ip: 10.1.12.102
      admin_username: <USERNAME>
      admin_password: <PASSWORD>

# Azure Configuration
azure:
  subscription_id: <your_subscription_id>
  cloud_region: westeurope
  location: francecentral
  address_space: 10.1.0.0/16
  subnet_transport_prefix: 10.1.11.0/24
  subnet_service_prefix: 10.1.12.0/24
  image_publisher: cisco
  image_offer: cisco-c8000v-byol
  image_sku: 17_14_01a-byol
  image_version: latest
  vm_size: Standard_D2_v2
  image_id: cisco-c8000v-byol
  site_id: 1002

  edge_instances:
    - hostname: edge-3
      uuid: C8K-XXXX-XXXX-XXXX-XXXX
      otp: xxxxxxxxxxxx
      system_ip: 192.168.103.1
      transport_ip: 10.1.11.103
      service_ip: 10.1.12.103
      admin_username: <USERNAME>
      admin_password: <PASSWORD>

```
