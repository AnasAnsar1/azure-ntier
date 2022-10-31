resource "azurerm_virtual_network" "vnet" {
  name                = format("vnetfromtf%s", terraform.workspace)
  resource_group_name = azurerm_resource_group.rsg.name
  location            = azurerm_resource_group.rsg.location
  address_space       = local.address_space
}
resource "azurerm_subnet" "subnets" {
  count                = length(var.subnets_details.names)
  name                 = var.subnets_details.names[count.index]
  address_prefixes     = [var.subnets_details.address_prefixes[count.index]]
  resource_group_name  = azurerm_resource_group.rsg.name
  virtual_network_name = azurerm_virtual_network.vnet.name

  depends_on = [
    azurerm_virtual_network.vnet
  ]
  
}
