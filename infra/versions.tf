terraform {
  required_version = ">= 1.9"

  # Remaining settings come from backend.hcl locally and from flags in CI.
  backend "azurerm" {
    container_name   = "tfstate"
    key              = "infra.tfstate"
    use_azuread_auth = true
  }

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

provider "azurerm" {
  storage_use_azuread = true

  features {
    storage {
      # Lets the read-only CI identity plan without storage data access.
      data_plane_available = false
    }
  }
}
