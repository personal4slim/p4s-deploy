resource "azurerm_kubernetes_cluster_node_pool" "lin101" {
  name                  = "lin101"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks_cluster.id
  vm_size               = "Standard_DS2_v2"
  os_type               = "Linux"
  os_disk_size_gb       = 35
  mode                  = "System"  # Use "System" mode for system node pools

  enable_auto_scaling = true
  max_count           = 3
  min_count           = 1

  node_labels = {
    "nodepool-type"  = "user"
    "environment"    = "dev"  # Corrected the typo in "environment"
    "nodepoolos"     = "linux"
    "app"            = "java-apps"
  }

  tags = {
    "nodepool-type"  = "user"
    "environment"    = "dev"
    "nodepools"      = "linux"
    "app"            = "java-apps"
  }

  priority = "Regular"
}
