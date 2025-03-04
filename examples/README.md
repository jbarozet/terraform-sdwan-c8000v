# Tests of aws/azure c8000v terraform modules

Modules:

- https://github.com/jbarozet/terraform-catalystwan-c8000v/modules/terraform-catalystwan-aws-vpc
- https://github.com/jbarozet/terraform-catalystwan-c8000v/modules/terraform-catalystwan-aws-c8000v
- https://github.com/jbarozet/terraform-catalystwan-c8000v/modules/terraform-catalystwan-azure-vnet
- https://github.com/jbarozet/terraform-catalystwan-c8000v/modules/terraform-catalystwan-azure-c8000v

Create VPC or VNET first, using module vpc/vnet:

```hcl
module "my_vpc" {
  source = "../modules/terraform-sdwan-aws-vpc"

  name                    = sdwanlab
  location                = francecentral
  address_space           = 10.1.0.0/16
  subnet_transport_prefix = 10.1.11.0/24
  subnet_service_prefix   = 10.1.12.0/24
}
```

Then instantiate a C8000v instance in that vpc using c8000v module:

```hcl
module "c8000v_1" {
  source = "../modules/terraform-sdwan-aws-c8000v"

  # SD-WAN Overlay Parameters
  name              = sdwanlab
  organization_name = orgname-test
  vbond             = 192.168.3.1
  vbond_port        = 12346

  # AWS Parameters
  cloud_region      = eu-west-3
  availability_zone = eu-west-3a
  image_id          = ami-xxxxxxxxxxxx
  instance_type     = c5n.large
  site_id           = 1001

  # VPC parameters: outputs from vpc module
  subnet_transport_id         = module.my_vpc.subnet_transport_id
  subnet_service_id           = module.my_vpc.subnet_service_id
  security_group_transport_id = module.my_vpc.security_group_transport_id
  security_group_service_id   = module.my_vpc.security_group_service_id

  # C8000v parameters
  hostname     = edge-1
  uuid         = C8K-XXXX-XXXX-XXXX-XXXX
  otp          = xxxxxxxxxxxx
  system_ip    = 192.168.101.1
  transport_ip = 10.1.11.101
  service_ip   = 10.1.12.101
  username     = admin
  password     = musupersecurepassword

}
```

Deploy VPC and C8000v:

```
terraform init
terraform plan
terraform apply --auto-approve
```

In the example provided, all parameters are conveniently specified in a YAML file (config.yaml).
Then a loop is used to create a C8000v resource for each edge instance defined in the AWS/Azure section of the configuration file.

```hcl
module "c8000v_aws" {
  source = "../modules/terraform-sdwan-aws-c8000v"
  for_each = { for instance in local.config.aws.edge_instances : instance.hostname => instance }

  [PARAMETERS]

```
