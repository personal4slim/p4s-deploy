resource "azurerm_resource_group" "aks_rg" {
  name = "p4s-testrg"
  location =  var.location
}