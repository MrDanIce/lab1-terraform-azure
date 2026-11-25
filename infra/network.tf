resource "azurerm_virtual_network" "lab" {
  name                = "vnet-lab1"
  resource_group_name = azurerm_resource_group.lab.name
  location            = azurerm_resource_group.lab.location
  address_space       = ["10.10.0.0/16"]
  tags                = local.tags
}

resource "azurerm_subnet" "vm" {
  name                            = "snet-vm"
  resource_group_name             = azurerm_resource_group.lab.name
  virtual_network_name            = azurerm_virtual_network.lab.name
  address_prefixes                = ["10.10.1.0/24"]
  default_outbound_access_enabled = false
}

# No public IP: the VM is tested through "az vm run-command".
resource "azurerm_network_interface" "vm" {
  name                = "nic-lab1"
  resource_group_name = azurerm_resource_group.lab.name
  location            = azurerm_resource_group.lab.location
  tags                = local.tags

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.vm.id
    private_ip_address_allocation = "Dynamic"
  }
}
