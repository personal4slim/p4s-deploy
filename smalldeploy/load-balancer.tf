resource "azurerm_lb" "dev" {
  name                = "example-lb-dev"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.dev.id
  }

  tags = var.tags

  backend_address_pool {
    name = "backendPool"
  }

  probe {
    name                      = "httpProbe"
    protocol                  = "HTTP"
    request_path              = "/"
    port                      = 80
    interval_in_seconds       = 5
    number_of_probes          = 2
  }

  load_balancing_rule {
    name                       = "httpRule"
    frontend_ip_configuration  = azurerm_lb.dev.frontend_ip_configuration[0].name
    backend_address_pool       = azurerm_lb.dev.backend_address_pool[0].name
    probe                      = azurerm_lb.dev.probe[0].name
    protocol                   = "Tcp"
    frontend_port              = 80
    backend_port               = 80
    enable_floating_ip         = false
  }
}

resource "azurerm_lb" "test" {
  name                = "example-lb-test"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.test.id
  }

  tags = var.tags

  backend_address_pool {
    name = "backendPool"
  }

  probe {
    name                      = "httpProbe"
    protocol                  = "HTTP"
    request_path              = "/"
    port                      = 80
    interval_in_seconds       = 5
    number_of_probes          = 2
  }

  load_balancing_rule {
    name                       = "httpRule"
    frontend_ip_configuration  = azurerm_lb.test.frontend_ip_configuration[0].name
    backend_address_pool       = azurerm_lb.test.backend_address_pool[0].name
    probe                      = azurerm_lb.test.probe[0].name
    protocol                   = "Tcp"
    frontend_port              = 80
    backend_port               = 80
    enable_floating_ip         = false
  }
}

resource "azurerm_lb" "prod" {
  name                = "example-lb-prod"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.prod.id
  }

  tags = var.tags

  backend_address_pool {
    name = "backendPool"
  }

  probe {
    name                      = "httpProbe"
    protocol                  = "HTTP"
    request_path              = "/"
    port                      = 80
    interval_in_seconds       = 5
    number_of_probes          = 2
  }

  load_balancing_rule {
    name                       = "httpRule"
    frontend_ip_configuration  = azurerm_lb.prod.frontend_ip_configuration[0].name
    backend_address_pool       = azurerm_lb.prod.backend_address_pool[0].name
    probe                      = azurerm_lb.prod.probe[0].name
    protocol                   = "Tcp"
    frontend_port              = 80
    backend_port               = 80
    enable_floating_ip         = false
  }
}
