output "nginx" {
    value = format("http://%s",azurerm_linux_virtual_machine.vmachine.public_ip_address)
}