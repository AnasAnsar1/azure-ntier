resource "azurerm_mssql_server" "mssql_server" {
  name                          = format("lessservertf%s", terraform.workspace)
  resource_group_name           = azurerm_resource_group.rsg.name
  location                      = azurerm_resource_group.rsg.location
  version                       = "12.0"
  administrator_login           = "lessserver"
  administrator_login_password  = "lessVserver@123"
  minimum_tls_version           = "1.2"
  public_network_access_enabled = true

  depends_on = [
    azurerm_resource_group.rsg,
    azurerm_virtual_network.vnet
  ]
}

resource "azurerm_mssql_database" "mssql_db" {
  name        = format("lessdbtf%s", terraform.workspace)
  server_id   = azurerm_mssql_server.mssql_server.id
  sample_name = "AdventureWorksLT"
  sku_name    = "Basic"

  tags = {
    Env = terraform.workspace
  }

  depends_on = [
    azurerm_mssql_server.mssql_server
  ]

}
