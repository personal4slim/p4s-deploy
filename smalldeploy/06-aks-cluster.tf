resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = "${azurerm_resource_group.aks_rg.name}-cluster"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  dns_prefix          = "${azurerm_resource_group.aks_rg.name}-cluster"
  kubernetes_version = data.azurerm_kubernetes_service_versions.current.latest_version
  node_resource_group = "${azurerm_resource_group.aks_rg.name}-nrg"

  default_node_pool {
    name                = "p4spool"
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

  # Role Based Access Control
  azure_active_directory_role_based_access_control {
    managed              = true
    admin_group_object_ids = ["002fae4f-5ba5-47f1-800a-70d428de60b7"]
  }

  network_profile {
    network_plugin = "azure"  # Use the "azure" network plugin for Windows agent pool
  }

  windows_profile {
    admin_username = "personal4slim"
    admin_password = "Oluwaseun_101#"
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "win231" {
  name                  = "win232"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks_cluster.id
  vm_size               = "Standard_DS2_v2"
  os_type               = "Linux"
  os_disk_size_gb       = 35
  mode                  = "User"

  enable_auto_scaling = true
  max_count           = 3
  min_count           = 1

  node_labels = {
    "nodepool-type" = "user"
    "environment"   = "dev"
    "nodepoolos"    = "linux"
    "app"           = "system-apps"
  }

  tags = {
    "nodepool-type" = "user"
    "environment"   = "dev"
    "nodepools"     = "linux"
    "app"           = "system-apps"
  }

  priority = "Regular"
}
