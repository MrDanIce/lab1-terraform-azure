terraform {
  required_version = ">= 1.9"

  # Local state on purpose: this config creates the storage that holds remote state.
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.40.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}

# Subscription comes from the ARM_SUBSCRIPTION_ID environment variable.
provider "azurerm" {
  features {}
  storage_use_azuread = true
}
