# Deploying C8000v on AWS

A basic example to deploy C8000v in SD-WAN mode on AWS.

This folder shows an example of Terraform code that uses the following modules:
- terraform-sdwan-aws-vpc,
- terraform-sdwan-aws-c8000v


## Quick start

1. `git clone` this repo to your computer
2. Go to the `examples/aws` folder
3. Create a terraform.tfvars file add add your variables values.
4. Run `terraform init`
5. Run `terraform plan`
6. If the plan looks good, run `terraform apply --auto-approve`
