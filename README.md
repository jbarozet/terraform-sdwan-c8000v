# Catalyst 8000v SD-WAN AWS and Azure Module

This repo contains a module for deploying Catalyst 8000v in Controller Mode (SD-WAN) on Azure and AWS using Terraform.

## How to use this module

This module has the following structure:

- [Root](https://github.com/jbarozet/terraform-sdwan-c8000v/blob/main/MAIN.md): This folder shows an example of Terraform code to deploy C8000v on AWS and Azure
- [Modules](https://github.com/jbarozet/terraform-sdwan-c8000v/tree/main/modules): This folder contains the reusable code for this Module, broken down into more modules
- [Examples](https://github.com/jbarozet/terraform-sdwan-c8000v/tree/main/examples): This folder contains examples of how to use the modules.

## Code included in this Module

- [Create AWS VPC](https://github.com/jbarozet/terraform-sdwan-c8000v/tree/main/modules/terraform-sdwan-aws-vpc)
- [Deploy C8000v instances in AWS VPC](https://github.com/jbarozet/terraform-sdwan-c8000v/tree/main/modules/terraform-sdwan-aws-c8000v)
- [Create Azure VNET](https://github.com/jbarozet/terraform-sdwan-c8000v/tree/main/modules/terraform-sdwan-azure-vnet)
- [Deploy C8000v instances in Azure VNET](https://github.com/jbarozet/terraform-sdwan-c8000v/tree/main/modules/terraform-sdwan-azure-c8000v)
