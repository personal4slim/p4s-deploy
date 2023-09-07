resource "random_pet" "aksrandom" {
  length = 8
}

resource "azurerm_log_analytics_workspace" "insights" {
  name                = "log-p4s-analytics"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags                = azurerm_resource_group.aks_rg.tags
}
