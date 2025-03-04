# C8000v Deployment on AWS/Azure

## Modules used

- https://github.com/jbarozet/terraform-catalystwan-c8000v/modules/terraform-catalystwan-aws-vpc
- https://github.com/jbarozet/terraform-catalystwan-c8000v/modules/terraform-catalystwan-aws-c8000v
- https://github.com/jbarozet/terraform-catalystwan-c8000v/modules/terraform-catalystwan-azure-vnet
- https://github.com/jbarozet/terraform-catalystwan-c8000v/modules/terraform-catalystwan-azure-c8000v

This folder shows an example of Terraform code to deploy:
- 2 x C8000v instances in an AWS VPC
- 1 x C8000v instance in an Azure VNET.

## Quick start

1. copy `config_examples.yaml` to `config.yaml`
2. update parameters in `config.yaml`
3. Run `terraform init`
4. Run `terraform plan`
5. If the plan looks good, run `terraform apply --auto-approve`

## Destroy all resources

Run `terraform destroy --auto-approve`
