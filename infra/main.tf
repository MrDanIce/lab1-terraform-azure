locals {
  tags = {
    project    = "lab1-terraform"
    managed_by = "terraform"
    purpose    = "lab"
  }
}

resource "azurerm_resource_group" "lab" {
  name     = "rg-lab1"
  location = var.location
  tags     = local.tags
}

resource "random_string" "suffix" {
  length  = 8
  upper   = false
  special = false
}

resource "azurerm_storage_account" "lab" {
  name                            = "stlab1${random_string.suffix.result}"
  resource_group_name             = azurerm_resource_group.lab.name
  location                        = azurerm_resource_group.lab.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = false
  shared_access_key_enabled       = false
  tags                            = local.tags
}
