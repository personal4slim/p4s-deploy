# Define the Azure Kubernetes Cluster
resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = "my-aks-cluster"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  dns_prefix          = "myakscluster"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure"
    load_balancer_sku = "Standard"
  }

  addon_profile {
    oms_agent {
      enabled                    = false
    }
  }

  role_based_access_control {
    enabled = true
  }

  tags = {
    environment = "Dev"
  }

  # Reference to the outbound IP prefixes from the load balancers
  outbound_ip_prefix_ids = [
    azurerm_public_ip.dev.id,
    azurerm_public_ip.test.id,
    azurerm_public_ip.prod.id
  ]
}

# Define managed public IP addresses for dev, test, and prod environments
resource "azurerm_public_ip" "dev" {
  name                = "my-app-service-dev-public-ip"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  allocation_method   = "Dynamic"
}

resource "azurerm_public_ip" "test" {
  name                = "my-app-service-test-public-ip"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  allocation_method   = "Dynamic"
}

resource "azurerm_public_ip" "prod" {
  name                = "my-app-service-prod-public-ip"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  allocation_method   = "Dynamic"
}
