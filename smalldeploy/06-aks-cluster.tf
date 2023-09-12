resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = "my-aks-cluster"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  dns_prefix          = "myakscluster"
  kubernetes_version  = "1.21.2"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_DS2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure"
    load_balancer_sku = "Standard"
  }

  addon_profile {
    kube_dashboard {
      enabled = true
    }

    oms_agent {
      enabled = true
      log_analytics_workspace_id = azurerm_log_analytics_workspace.example.id
    }
  }

  role_based_access_control {
    enabled = true
  }

  tags = {
    Environment = "Dev"
  }
}

data "azurerm_log_analytics_workspace" "example" {
  name                = "example"
  resource_group_name = azurerm_resource_group.aks_rg.name
}

# Other resources related to your AKS cluster
