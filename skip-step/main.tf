terraform {
  backend "azurerm" {
  }
}

provider "azurerm" {
  version = ">=2.0"
  skip_provider_registration = true
  # The "feature" block is required for AzureRM provider 2.x.
  features {}
}

resource "azurerm_kubernetes_cluster" "example-aks1" {
  name                = "example-aks1"
  location            = "East US"
  resource_group_name = "aks-best-practices-rg3"
  dns_prefix          = "exampleaks1"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}

