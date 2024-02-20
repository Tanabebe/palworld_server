resource "azurerm_resource_group" "rg" {
  name     = "${var.base_name}-rg"
  location = var.resource_group_location
}

resource "azurerm_linux_virtual_machine" "palworld_vm" {
  name                  = "${var.base_name}-vm"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  computer_name         = "${var.base_name}-host"
  network_interface_ids = [azurerm_network_interface.palworld_network_if.id]
  size                  = var.vm_machine_type

  admin_username = var.username

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  admin_ssh_key {
    username   = var.username
    public_key = file("~/.ssh/az_key.pub")
  }

  os_disk {
    name                 = "${var.base_name}-os-disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = var.disk_size
  }

  tags = {
    environment = "production",
    name        = "${var.vm_tag_name}"
  }
}