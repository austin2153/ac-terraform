terraform {
  required_version = ">= 1.0.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.0"
    }
  }
  # Terraform State Storage to Azure Storage Container
  backend "azurerm" {
    resource_group_name  = "terraform-storage-rg"
    storage_account_name = "acterraformstate201"
    container_name       = "tfstatefiles"
    key                  = "test.tfstate"
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# Extract variables and generates locals
# that depends on what workspace/env we are setting up
locals {
  name = "${var.name}-${terraform.workspace}"
  tags = merge(var.tags, {
    "env"  = terraform.workspace,
    "port" = var.port[terraform.workspace]
    }
  )
  port = var.port[terraform.workspace]
}

resource "azurerm_resource_group" "rg" {
  name     = local.name
  location = var.region
  tags     = local.tags
}
