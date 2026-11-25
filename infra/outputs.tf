output "resource_group" {
  value = azurerm_resource_group.lab.name
}

output "vm_name" {
  value = azurerm_linux_virtual_machine.lab.name
}

output "storage_account" {
  value = azurerm_storage_account.lab.name
}

output "vm_private_ip" {
  value = azurerm_network_interface.vm.private_ip_address
}
