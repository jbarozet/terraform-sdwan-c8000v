# Terraform SD-WAN C8000v in AWS module

Module to deploy C8000v instances in AWS.

## Create AWS VPC

Create your VPC to host C8000v instances using the `terraform-sdwan-aws-vpc` module:

```hcl
provider "aws" {
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "default"
  region                   = eu-west-3
}

module "my_vpc" {
  source = "jbarozet/c8000v/sdwan//modules/terraform-sdwan-aws-vpc"


  name                    = sdwanlab
  availability_zone       = eu-west-3a
  address_space           = 10.1.0.0/16
  subnet_transport_prefix = 10.1.11.0/24
  subnet_service_prefix   = 10.1.12.0/24

}
```

## Deploy C8000v instances in AWS

Then deploy C8000v instances.
Deploy as many instances as you need. They will be instantiated in the same VPC.

```hcl
module "c8000v_1" {
  source = "jbarozet/c8000v/sdwan//modules/terraform-sdwan-aws-c8000v"

  # SD-WAN Overlay Parameters
  name              = sdwanlab
  organization_name = [ORG_NAME]
  vbond             = 192.168.3.1
  vbond_port        = 12346

  # AWS Parameters
  cloud_region      = eu-west-3
  availability_zone = eu-west-3a
  image_id          = [ami-xxxxxxxxxxxx]
  instance_type     = c5n.large
  site_id           = 1001

  # VPC parameters: outputs from vpc module
  subnet_transport_id         = module.my_vpc.subnet_transport_id
  subnet_service_id           = module.my_vpc.subnet_service_id
  security_group_transport_id = module.my_vpc.security_group_transport_id
  security_group_service_id   = module.my_vpc.security_group_service_id

  # C8000v parameters
  hostname     = edge-1
  uuid         = [C8K-XXXX-XXXX-XXXX-XXXX]
  otp          = [xxxxxxxxxxxx]
  system_ip    = 192.168.101.1
  transport_ip = 10.1.11.101
  service_ip   = 10.1.12.101
  username     = [USERNAME]
  password     = [PASSWORD]

}
```
