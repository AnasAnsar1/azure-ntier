resource "azurerm_resource_group" "rsg" {
  name     = var.rsg_details.name
  location = var.rsg_details.location
}