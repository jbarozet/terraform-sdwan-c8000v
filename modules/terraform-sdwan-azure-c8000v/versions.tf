
terraform {
  required_version = ">=1.3.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=4.10.0"
    }
    local = {
      source  = "hashicorp/local"
      version = ">= 2.5.0"
    }
  }
}
