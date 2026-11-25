data "azurerm_subscription" "current" {}

data "azurerm_client_config" "current" {}

locals {
  tags = {
    project    = "lab1-terraform"
    managed_by = "terraform"
    purpose    = "bootstrap"
  }
}

# Budget alert, created before any billable VM.
resource "azurerm_consumption_budget_subscription" "lab" {
  name            = "lab1-monthly-budget"
  subscription_id = data.azurerm_subscription.current.id
  amount          = var.budget_amount
  time_grain      = "Monthly"

  time_period {
    start_date = var.budget_start_date
  }

  notification {
    enabled        = true
    threshold      = 50
    operator       = "GreaterThan"
    threshold_type = "Actual"
    contact_emails = [var.budget_email]
  }

  notification {
    enabled        = true
    threshold      = 100
    operator       = "GreaterThan"
    threshold_type = "Forecasted"
    contact_emails = [var.budget_email]
  }
}

resource "azurerm_resource_group" "state" {
  name     = "rg-lab1-tfstate"
  location = var.location
  tags     = local.tags
}

resource "random_string" "suffix" {
  length  = 8
  upper   = false
  special = false
}

resource "azurerm_storage_account" "state" {
  name                            = "tfstate${random_string.suffix.result}"
  resource_group_name             = azurerm_resource_group.state.name
  location                        = azurerm_resource_group.state.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = false
  shared_access_key_enabled       = false
  tags                            = local.tags

  blob_properties {
    versioning_enabled = true
  }
}

resource "azurerm_storage_container" "state" {
  name                  = "tfstate"
  storage_account_id    = azurerm_storage_account.state.id
  container_access_type = "private"
}

# My own login: read and write state.
resource "azurerm_role_assignment" "me_state" {
  scope                = azurerm_storage_account.state.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = data.azurerm_client_config.current.object_id
}

# GitHub Actions identity: passwordless login, read-only roles, so CI cannot apply.
resource "azurerm_user_assigned_identity" "ci" {
  name                = "id-lab1-github-plan"
  resource_group_name = azurerm_resource_group.state.name
  location            = azurerm_resource_group.state.location
  tags                = local.tags
}

resource "azurerm_federated_identity_credential" "pull_request" {
  name                = "github-pull-request"
  resource_group_name = azurerm_resource_group.state.name
  parent_id           = azurerm_user_assigned_identity.ci.id
  issuer              = "https://token.actions.githubusercontent.com"
  audience            = ["api://AzureADTokenExchange"]
  subject             = "repo:${var.github_repo}:pull_request"
}

resource "azurerm_role_assignment" "ci_reader" {
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Reader"
  principal_id         = azurerm_user_assigned_identity.ci.principal_id
}

resource "azurerm_role_assignment" "ci_state" {
  scope                = azurerm_storage_account.state.id
  role_definition_name = "Storage Blob Data Reader"
  principal_id         = azurerm_user_assigned_identity.ci.principal_id
}
