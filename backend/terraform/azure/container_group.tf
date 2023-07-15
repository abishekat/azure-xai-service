resource "azurerm_container_group" "backendcentral" {
  name                = "xai-central"
  location            = "East US"
  resource_group_name = "aci-xai-rg"
  os_type             = "Linux" 
  ip_address_type     = "Public"
  dns_name_label      = "aci-xai-backendcentral-dns"

  image_registry_credential {
    server   = "xaicontainerregistry.azurecr.io"
    username = "xaicontainerregistry"
    password = var.registry_password
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


resource "azurerm_container_group" "azureblob" {
  name                = "xai-azureblob"
  location            = "East US"
  resource_group_name = "aci-xai-rg"
  os_type             = "Linux" 
  ip_address_type     = "Public"
  dns_name_label      = "aci-xai-azureblob-dns"

  image_registry_credential {
    server   = "xaicontainerregistry.azurecr.io"
    username = "xaicontainerregistry"
    password = var.registry_password
  }

  container {
    name   = "azureblob"
    image  = "xaicontainerregistry.azurecr.io/backendazureblob:latest"
    cpu    = "1"
    memory = "10"

    ports {
      port     = 5009
      protocol = "TCP"
    }
  }
}

resource "azurerm_container_group" "azurecog" {
  name                = "xai-azurecog"
  location            = "East US"
  resource_group_name = "aci-xai-rg"
  os_type             = "Linux" 
  ip_address_type     = "Public"
  dns_name_label      = "aci-xai-azurecog-dns"

  image_registry_credential {
    server   = "xaicontainerregistry.azurecr.io"
    username = "xaicontainerregistry"
    password = var.registry_password
  }

  container {
    name   = "azurecog"
    image  = "xaicontainerregistry.azurecr.io/backendazurecog:latest"
    cpu    = "1"
    memory = "10"

    ports {
      port     = 5007
      protocol = "TCP"
    }
  }
}

resource "azurerm_container_group" "backendevaluationservice" {
  name                = "xai-backendevaluationservice"
  location            = "East US"
  resource_group_name = "aci-xai-rg"
  os_type             = "Linux" 
  ip_address_type     = "Public"
  dns_name_label      = "aci-xai-backendevaluationservice-dns"

  image_registry_credential {
    server   = "xaicontainerregistry.azurecr.io"
    username = "xaicontainerregistry"
    password = var.registry_password
  }

  container {
    name   = "backendevaluationservice"
    image  = "xaicontainerregistry.azurecr.io/backendevaluationservice:latest"
    cpu    = "1"
    memory = "10"

    ports {
      port     = 5004
      protocol = "TCP"
    }
  }
}

resource "azurerm_container_group" "restnet50" {
  name                = "xai-restnet50"
  location            = "East US"
  resource_group_name = "aci-xai-rg"
  os_type             = "Linux" 
  ip_address_type     = "Public"
  dns_name_label      = "aci-xai-restnet50-dns"

  image_registry_credential {
    server   = "xaicontainerregistry.azurecr.io"
    username = "xaicontainerregistry"
    password = var.registry_password
  }

  container {
    name   = "restnet50"
    image  = "xaicontainerregistry.azurecr.io/backendrestnet50:latest"
    cpu    = "1"
    memory = "10"

    ports {
      port     = 5001
      protocol = "TCP"
    }
  }
}
