resource "azurecaf_name" "hub-name" {
  resource_types = [
    "azurerm_resource_group",
    "azurerm_virtual_network"
  ]
  name     = "hub"
  prefixes = [var.tenant-short-name]
}

resource "azurerm_resource_group" "connectivity-resource-group" {
  name     = azurecaf_name.hub-name.results.azurerm_resource_group
  location = var.location
}

resource "azurerm_virtual_network" "hub-vnet" {
  name                = azurecaf_name.hub-name.results.azurerm_virtual_network
  resource_group_name = azurerm_resource_group.connectivity-resource-group.name
  address_space       = var.hub-vnet-address-space
  location            = var.location
}

resource "azurerm_subnet" "bastion-subnet" {
  count = var.bastion-subnet-space == null ? 0 : 1

  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.connectivity-resource-group.name
  virtual_network_name = azurerm_virtual_network.hub-vnet.name
  address_prefixes     = [var.bastion-subnet-space]
}
