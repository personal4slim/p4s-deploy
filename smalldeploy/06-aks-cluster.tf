# Define a managed public IP address for dev environment
resource "azurerm_public_ip" "dev" {
  name                = "my-app-service-dev-public-ip"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  allocation_method   = "Dynamic"
}

# Define a managed public IP address for test environment
resource "azurerm_public_ip" "test" {
  name                = "my-app-service-test-public-ip"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  allocation_method   = "Dynamic"
}

# Define a managed public IP address for prod environment
resource "azurerm_public_ip" "prod" {
  name                = "my-app-service-prod-public-ip"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  allocation_method   = "Dynamic"
}

# Define Load Balancer resources for dev, test, and prod environments
resource "azurerm_lb" "dev" {
  name                = "my-app-service-dev-lb"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.dev.id
  }

  # ... (other LB configuration settings)
}

resource "azurerm_lb" "test" {
  name                = "my-app-service-test-lb"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.test.id
  }

  # ... (other LB configuration settings)
}

resource "azurerm_lb" "prod" {
  name                = "my-app-service-prod-lb"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.prod.id
  }

  # ... (other LB configuration settings)
}

# Define Kubernetes Cluster
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

  service_principal {
    client_id     = azurerm_kubernetes_cluster_sp.aks_sp.application_id
    client_secret = azurerm_kubernetes_cluster_sp.aks_sp.password
  }

  network_profile {
    load_balancer_profile {
      managed_outbound_ip_count = 1
      outbound_ip_prefix_ids = [
        azurerm_public_ip.dev.id,
        azurerm_public_ip.test.id,
        azurerm_public_ip.prod.id
      ]
    }
  }

  tags = {
    environment = "Development"
  }
}
