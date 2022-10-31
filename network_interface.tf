resource "azurerm_network_interface" "nic" {
  name                = "less_nic"
  location            = azurerm_resource_group.rsg.location
  resource_group_name = azurerm_resource_group.rsg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnets[0].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public.id
  }

  depends_on = [
    azurerm_subnet.subnets,
    azurerm_public_ip.public
  ]
}

resource "azurerm_network_interface_security_group_association" "example" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}
