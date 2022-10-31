resource "azurerm_linux_virtual_machine" "vmachine" {
  resource_group_name             = azurerm_resource_group.rsg.name
  location                        = var.location
  name                            = format("vmachine-tf%s", terraform.workspace)
  size                            = "Standard_B1s"
  admin_username                  = "ubuntu"
  admin_password                  = "123456789@Aa"
  network_interface_ids           = [azurerm_network_interface.nic.id]
  disable_password_authentication = false

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}

resource "null_resource" "cluster" {
  triggers = {
    number = var.running_number
  }


  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install nginx -y"
    ]
  }

  connection {
    host     = azurerm_linux_virtual_machine.vmachine.public_ip_address
    user     = "ubuntu"
    password = "123456789@Aa"
  }
}




