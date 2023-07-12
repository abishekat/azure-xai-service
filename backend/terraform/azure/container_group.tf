resource "azurerm_container_group" "backendcentral" {
  name                = "xai-central"
  location            = azurerm_resource_group.xai.location
  resource_group_name = azurerm_resource_group.xai.name
  os_type             = "Linux" 
  ip_address_type     = "Public"
  dns_name_label      = "aci-xai-backendcentral-dns"

  image_registry_credential {
    server   = "backendcentral.azurecr.io"
    username = "backendcentral"
    password = "nDgUVRcfa/7BmsDQ1Lei/TlTon2cFLgtIQRdm7Bqo6+ACRB0Wywr"
  }

  container {
    name   = "backendcentral"
    image  = "backendcentral.azurecr.io/backendcentral:latest"
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
  location            = azurerm_resource_group.xai.location
  resource_group_name = azurerm_resource_group.xai.name
  os_type             = "Linux" 
  ip_address_type     = "Public"
  dns_name_label      = "aci-xai-azureblob-dns"

  image_registry_credential {
    server   = "azureblob.azurecr.io"
    username = "azureblob"
    password = "LSWjyPU4oKd/a/wupkaGXzpD1WZfClSzoratRao9Cd+ACRDbYPbD"
  }

  container {
    name   = "azureblob"
    image  = "azureblob.azurecr.io/azureblob:latest"
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
  location            = azurerm_resource_group.xai.location
  resource_group_name = azurerm_resource_group.xai.name
  os_type             = "Linux" 
  ip_address_type     = "Public"
  dns_name_label      = "aci-xai-azurecog-dns"

  image_registry_credential {
    server   = "azurecog.azurecr.io"
    username = "azurecog"
    password = "29VfudHYVD+I4aS3HBOlLEfOzSW5eiqwU/ChIk30AP+ACRBtpImX"
  }

  container {
    name   = "azurecog"
    image  = "azurecog.azurecr.io/azurecog:latest"
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
  location            = azurerm_resource_group.xai.location
  resource_group_name = azurerm_resource_group.xai.name
  os_type             = "Linux" 
  ip_address_type     = "Public"
  dns_name_label      = "aci-xai-backendevaluationservice-dns"

  image_registry_credential {
    server   = "backendevaluationservice.azurecr.io"
    username = "backendevaluationservice"
    password = "sXqoMavceAtIngmLPDAlSQBE1koGy8RPAh0b1IgURk+ACRDt2Ynt"
  }

  container {
    name   = "backendevaluationservice"
    image  = "backendevaluationservice.azurecr.io/backendevaluationservice:latest"
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
  location            = azurerm_resource_group.xai.location
  resource_group_name = azurerm_resource_group.xai.name
  os_type             = "Linux" 
  ip_address_type     = "Public"
  dns_name_label      = "aci-xai-restnet50-dns"

  image_registry_credential {
    server   = "restnet50.azurecr.io"
    username = "restnet50"
    password = "/EeX8pRBoqY8A9oDQjC1Ep7sJGeS1qyv2NZy+q7cTz+ACRDf0qTp"
  }

  container {
    name   = "restnet50"
    image  = "restnet50.azurecr.io/restnet50:latest"
    cpu    = "1"
    memory = "10"

    ports {
      port     = 5001
      protocol = "TCP"
    }
  }
}
