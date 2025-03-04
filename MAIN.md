# Deploying C8000v on Azure and AWS

This folder shows an example of Terraform code that uses the following modules:
- terraform-sdwan-aws-vpc,
- terraform-sdwan-aws-c8000v
- terraform-sdwan-azure-vnet
- terraform-sdwan-azure-c8000v modules

to deploy C8000v in SD-WAN mode in AWS and Azure:
- 2 x C8000v instances in an AWS VPC
- 1 x C8000v instance in an Azure VNET.

## Quick start

1. `git clone` this repo to your computer
2. copy `config_examples.yaml` to `config.yaml`
3. update parameters in `config.yaml`
4. Run `terraform init`
5. Run `terraform plan`
6. If the plan looks good, run `terraform apply --auto-approve`
