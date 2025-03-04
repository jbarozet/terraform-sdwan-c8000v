# Terraform SD-WAN VPC module

Module for creating a VPC in AWS, designed specifically for deploying C8000v in SD-WAN mode.

## Create AWS VPC

Create your VPC to host C8000v instances using the `terraform-sdwan-aws-vpc` module.
Create service and transport subnets with the appropriate seecurity group definition.

```hcl
provider "aws" {
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "default"
  region                   = eu-west-3
}

module "my_vpc" {
  source = "app.terraform.io/jbarozet/terraform-sdwan-c8000v//modules/terraform-sdwan-aws-vpc"

  name                    = sdwanlab
  availability_zone       = eu-west-3a
  address_space           = 10.1.0.0/16
  subnet_transport_prefix = 10.1.11.0/24
  subnet_service_prefix   = 10.1.12.0/24

}
```
