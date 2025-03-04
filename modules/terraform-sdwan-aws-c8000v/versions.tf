terraform {
  required_version = ">=1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.89"
    }
    local = {
      source  = "hashicorp/local"
      version = ">= 2.5.0"
    }
  }
}
