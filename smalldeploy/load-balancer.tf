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

  backend_address_pool {
    name = "backendPool1"
  }

  probe {
    name         = "httpProbe"
    protocol     = "Http"
    request_path = "/"
    port         = 80
  }

  load_balancing_rule {
    name                       = "webRule"
    frontend_ip_configuration_id = azurerm_lb.dev.frontend_ip_configuration[0].id
    backend_address_pool_id      = azurerm_lb.dev.backend_address_pool[0].id
    probe_id                    = azurerm_lb.dev.probe[0].id
    protocol                    = "Tcp"
    frontend_port               = 80
    backend_port                = 80
  }
}

# Define Load Balancer resources for test environment (similar to dev)
resource "azurerm_lb" "test" {
  name                = "my-app-service-test-lb"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.test.id
  }

  backend_address_pool {
    name = "backendPool1"
  }

  probe {
    name         = "httpProbe"
    protocol     = "Http"
    request_path = "/"
    port         = 80
  }

  load_balancing_rule {
    name                       = "webRule"
    frontend_ip_configuration_id = azurerm_lb.test.frontend_ip_configuration[0].id
    backend_address_pool_id      = azurerm_lb.test.backend_address_pool[0].id
    probe_id                    = azurerm_lb.test.probe[0].id
    protocol                    = "Tcp"
    frontend_port               = 80
    backend_port                = 80
  }
}

# Define Load Balancer resources for prod environment (similar to dev and test)
resource "azurerm_lb" "prod" {
  name                = "my-app-service-prod-lb"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.prod.id
  }

  backend_address_pool {
    name = "backendPool1"
  }

  probe {
    name         = "httpProbe"
    protocol     = "Http"
    request_path = "/"
    port         = 80
  }

  load_balancing_rule {
    name                       = "webRule"
    frontend_ip_configuration_id = azurerm_lb.prod.frontend_ip_configuration[0].id
    backend_address_pool_id      = azurerm_lb.prod.backend_address_pool[0].id
    probe_id                    = azurerm_lb.prod.probe[0].id
    protocol                    = "Tcp"
    frontend_port               = 80
    backend_port                = 80
  }
}
