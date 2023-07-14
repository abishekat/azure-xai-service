variable "azure_client_id" {
  description = "Username for the Docker container"
}

variable "azure_password" {
  description = "Password for the Docker container"
}

variable "azure_tenant_id" {
  description = "Password for the Docker container"
}


resource "azurerm_virtual_network" "xai" {
  name                = "aci-xai-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.xai.location
  resource_group_name = azurerm_resource_group.xai.name
}

resource "azurerm_subnet" "xai" {
  name                 = "aci-xai-subnet"
  resource_group_name  = azurerm_resource_group.xai.name
  virtual_network_name = azurerm_virtual_network.xai.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "xai" {
  name                = "aci-xai-pip"
  location            = azurerm_resource_group.xai.location
  resource_group_name = azurerm_resource_group.xai.name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "xai" {
  name                = "aci-xai-nic"
  location            = azurerm_resource_group.xai.location
  resource_group_name = azurerm_resource_group.xai.name

  ip_configuration {
    name                          = "aci-xai-ipconfig"
    subnet_id                     = azurerm_subnet.xai.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.xai.id
  }
}

resource "azurerm_network_security_group" "xai" {
  name                = "aci-xai-nsg"
  location            = azurerm_resource_group.xai.location
  resource_group_name = azurerm_resource_group.xai.name

  security_rule {
    name                       = "allow_port_5003"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5003"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "allow_port_22"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface_security_group_association" "ni-sg-association" {
  network_interface_id      = azurerm_network_interface.xai.id
  network_security_group_id = azurerm_network_security_group.xai.id
}


resource "azurerm_virtual_machine" "xai" {
  name                = "aci-xai-vm"
  location            = azurerm_resource_group.xai.location
  resource_group_name = azurerm_resource_group.xai.name
  vm_size             = "Standard_D2s_v3"

  storage_os_disk {
    name              = "aci-xai-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "microsoft-dsvm"
    offer     = "ubuntu-2004"
    sku       = "2004-gen2"
    version   = "latest"
  }

  os_profile {
    computer_name  = "aci-xai-vm"
    admin_username = "adminuser"
    admin_password = "Password1234!"
    custom_data = base64encode(data.template_file.custom_script.rendered)
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  network_interface_ids = [azurerm_network_interface.xai.id]

  tags = {
    environment = "production"
  }
}

data "template_file" "custom_script" {
  template = <<-SCRIPT
    #!/bin/bash

    # Add your custom script commands here
    # For example:
    az login --service-principal --username ${var.azure_client_id} --password ${var.azure_password} --tenant ${var.azure_tenant_id}
    az acr login --name xaicontainerregistry
    docker pull xaicontainerregistry.azurecr.io/gradcam
    docker run -d -p 5003:5003 xaicontainerregistry.azurecr.io/gradcam

    SCRIPT
}
