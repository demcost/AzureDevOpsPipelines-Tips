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

resource "azurerm_resource_group" "aks-best-practices-rg3" {
  name     = "aks-best-practices-rg3"
  location = "East US"
}

resource "azurerm_kubernetes_cluster" "aks-best-practices-rg3" {
  name                = "example-aks1"
  location            = azurerm_resource_group.aks-best-practices-rg3.location
  resource_group_name = azurerm_resource_group.aks-best-practices-rg3.name
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

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.aks-best-practices-rg3.kube_config.0.client_certificate
  sensitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.aks-best-practices-rg3.kube_config_raw

  sensitive = true
}
