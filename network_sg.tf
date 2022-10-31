resource "azurerm_network_security_group" "nsg" {
  name                = format("nsgfromtf%s", terraform.workspace)
  location            = azurerm_resource_group.rsg.location
  resource_group_name = azurerm_resource_group.rsg.name

  security_rule {
    name                       = "ssh"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = local.anywhere
    destination_port_range     = local.ssh
    source_address_prefix      = local.anywhere
    destination_address_prefix = local.anywhere
  }

  security_rule {
    name                       = "http"
    priority                   = 310
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = local.anywhere
    destination_port_range     = local.http
    source_address_prefix      = local.anywhere
    destination_address_prefix = local.anywhere
  }


  tags = {
    environment = terraform.workspace
  }

  depends_on = [
    azurerm_resource_group.rsg
  ]
}

resource "azurerm_public_ip" "public" {
  name                = "public_ip"
  resource_group_name = azurerm_resource_group.rsg.name
  location            = azurerm_resource_group.rsg.location
  allocation_method   = "Dynamic"

  depends_on = [
    azurerm_resource_group.rsg
  ]

  tags = {
    Env = terraform.workspace
  }
}