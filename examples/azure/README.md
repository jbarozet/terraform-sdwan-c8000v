# Deploying C8000v on Azure

A basic example to deploy a single C8000v in SD-WAN mode on Azure.

This folder shows an example of Terraform code that uses the following modules:
- terraform-sdwan-azure-vnet
- terraform-sdwan-azure-c8000v modules


## Quick start

1. `git clone` this repo to your computer
2. Go to the `examples/azure` folder
3. Create a terraform.tfvars file add add your variables values.
4. Run `terraform init`
5. Run `terraform plan`
6. If the plan looks good, run `terraform apply --auto-approve`
