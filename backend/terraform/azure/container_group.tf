resource "azurerm_container_group" "backendcentral" {
  name                = "xai-central"
  location            = azurerm_resource_group.xai.location
  resource_group_name = azurerm_resource_group.xai.name
  os_type             = "Linux" 
  ip_address_type     = "Public"
  dns_name_label      = "aci-xai-backendcentral-dns"

  image_registry_credential {
    server   = "xaicontainerregistry.azurecr.io"
    username = "xaicontainerregistry"
    password = ${var.registry_password}
  }

  container {
    name   = "backendcentral"
    image  = "xaicontainerregistry.azurecr.io/backendcentral:latest"
    cpu    = "1"
    memory = "10"

    ports {
      port     = 5006
      protocol = "TCP"
    }
  }
}

