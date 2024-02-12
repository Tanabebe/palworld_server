terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.90.0"
    }
    azapi = {
      source  = "Azure/azapi"
      version = "1.12.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.0"
    }
  }
}
provider "azurerm" {
  features {}
}