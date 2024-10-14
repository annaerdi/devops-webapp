# Configuring the Azure provider
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id != "" ? var.subscription_id : ""
}

# Setting up the Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Creating the App Service Plan
resource "azurerm_app_service_plan" "asp" {
  name                = var.app_service_plan_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Free"
    size = "F1"
  }
}

# Creating the Web App
resource "azurerm_linux_web_app" "app" {
  name                = var.app_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_app_service_plan.asp.id

  site_config {
    app_command_line = "npm start"
    always_on        = false  # disable always_on for the free plan
  }

  app_settings = {
    SCM_DO_BUILD_DURING_DEPLOYMENT = "true"
    WEBSITE_RUN_FROM_PACKAGE       = "1"
  }
}
