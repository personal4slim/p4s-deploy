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
}

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
}

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
}

resource "azurerm_lb_rule" "dev" {
  name                      = "webRule"
  resource_group_name       = azurerm_resource_group.aks_rg.name
  loadbalancer_id           = azurerm_lb.dev.id
  frontend_ip_configuration = azurerm_lb.dev.frontend_ip_configuration[0].name
  frontend_port             = 80
  backend_address_pool_id    = azurerm_lb.dev.backend_address_pool[0].id
  probe_id                  = azurerm_lb.dev.probe[0].id
  protocol                  = "Tcp"
}

resource "azurerm_lb_rule" "test" {
  name                      = "webRule"
  resource_group_name       = azurerm_resource_group.aks_rg.name
  loadbalancer_id           = azurerm_lb.test.id
  frontend_ip_configuration = azurerm_lb.test.frontend_ip_configuration[0].name
  frontend_port             = 80
  backend_address_pool_id    = azurerm_lb.test.backend_address_pool[0].id
  probe_id                  = azurerm_lb.test.probe[0].id
  protocol                  = "Tcp"
}

resource "azurerm_lb_rule" "prod" {
  name                      = "webRule"
  resource_group_name       = azurerm_resource_group.aks_rg.name
  loadbalancer_id           = azurerm_lb.prod.id
  frontend_ip_configuration = azurerm_lb.prod.frontend_ip_configuration[0].name
  frontend_port             = 80
  backend_address_pool_id    = azurerm_lb.prod.backend_address_pool[0].id
  probe_id                  = azurerm_lb.prod.probe[0].id
  protocol                  = "Tcp"
}

