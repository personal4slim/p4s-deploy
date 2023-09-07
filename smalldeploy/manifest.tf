# Define an Azure Resource Group
resource "azurerm_resource_group" "my_resource_group" {
  name     = "my-resource-group"
  location = var.location
}

# Define an Azure Kubernetes Cluster
resource "azurerm_kubernetes_cluster" "my_aks_cluster" {
  name                = "my-aks-cluster"
  location            = azurerm_resource_group.my_resource_group.location
  resource_group_name = azurerm_resource_group.my_resource_group.name
  dns_prefix          = "my-aks-cluster"

  default_node_pool {
    name                = "my-node-pool"
    node_count          = 1
    vm_size             = "Standard_D2_v2"
    orchestrator_version = data.azurerm_kubernetes_service_versions.current.latest_version
    enable_auto_scaling = true
    max_count           = 3
    min_count           = 1
    os_disk_size_gb     = 30
    type                = "VirtualMachineScaleSets"
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure"
  }

  windows_profile {
    admin_username = var.windows_admin_username
    admin_password = var.windows_admin_password
  }
}

# Define an Azure Kubernetes Cluster Node Pool (Linux)
resource "azurerm_kubernetes_cluster_node_pool" "my_linux_node_pool" {
  name                  = "my-linux-node-pool"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.my_aks_cluster.id
  vm_size               = "Standard_DS2_v2"
  os_type               = "Linux"
  os_disk_size_gb       = 35
  mode                  = "System"

  enable_auto_scaling = true
  max_count           = 3
  min_count           = 1

  node_labels = {
    "nodepool-type" = "user"
    "environment"   = var.environment
    "nodepoolos"    = "linux"
    "app"           = "java-apps"
  }
}

# Define an Azure Kubernetes Cluster Node Pool (Windows)
resource "azurerm_kubernetes_cluster_node_pool" "my_windows_node_pool" {
  name                  = "my-windows-node-pool"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.my_aks_cluster.id
  vm_size               = "Standard_DS2_v2"
  os_type               = "Windows"
  os_disk_size_gb       = 35
  mode                  = "User"

  enable_auto_scaling = true
  max_count           = 3
  min_count           = 1

  node_labels = {
    "nodepool-type" = "user"
    "environment"   = var.environment
    "nodepoolos"    = "Windows"
    "app"           = "dotnet-apps"
  }
}

# Define an Azure Log Analytics Workspace
resource "azurerm_log_analytics_workspace" "my_insights" {
  name                = "my-log-analytics-workspace"
  location            = azurerm_resource_group.my_resource_group.location
  resource_group_name = azurerm_resource_group.my_resource_group.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

# Define an Azure Kubernetes Service Versions Data Source
data "azurerm_kubernetes_service_versions" "current" {
  location        = azurerm_resource_group.my_resource_group.location
  include_preview = false
}

# Output variables (optional)
output "location" {
  value = azurerm_resource_group.my_resource_group.location
}

output "resource_group_id" {
  value = azurerm_resource_group.my_resource_group.id
}

output "resource_group_name" {
  value = azurerm_resource_group.my_resource_group.name
}
