# C8000v Deployment Example

This folder shows an example of Terraform code that uses the followinfg modules:
- terraform-sdwan-aws-vpc,
- terraform-sdwan-aws-c8000v
- terraform-sdwan-azure-vnet
- terraform-sdwan-azure-c8000v modules

to deploy:
- 2 x C8000v instances in an AWS VPC
- 1 x C8000v instance in an Azure VNET.

## Quick start

1. `git clone` this repo to your computer
2. go to the examples folder
3. copy `config_examples.yaml` to `config.yaml`
4. update parameters in `config.yaml`
5. Run `terraform init`
6. Run `terraform plan`
7. If the plan looks good, run `terraform apply --auto-approve`
