output "state_resource_group" {
  value = azurerm_resource_group.state.name
}

output "state_storage_account" {
  value = azurerm_storage_account.state.name
}

output "ci_client_id" {
  value     = azurerm_user_assigned_identity.ci.client_id
  sensitive = true
}
