resource "azurerm_kubernetes_cluster_node_pool" "win101" {
  name                  = "win101"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks_cluster.id
  vm_size               = "Standard_DS2_v2"
  os_type               = "Windows"
  os_disk_size_gb       = 35
  mode                  = "User"

  enable_auto_scaling = true
  max_count           = 3
  min_count           = 1

  node_labels = {
    "nodepool-type" = "user"
    "environment"   = "dev"
    "nodepoolos"    = "Windows"
    "app"           = "dotnet-apps"
  }

  tags = {
    "nodepool-type" = "user"
    "environment"   = "dev"
    "nodepools"     = "windows"
    "app"           = "dotnet-apps"
  }

  priority = "Regular"
}
