# terraform-azurerm-logic-app

Terraform module for Azure Logic Apps supporting both Consumption and Standard tiers.

## Usage

### Consumption Logic App

```hcl
module "logic_app" {
  source = "./terraform-azurerm-logic-app"

  name                = "la-myworkflow-eastus2-dev"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  kind                = "consumption"
  identity_type       = "SystemAssigned"

  tags = {
    environment = "dev"
  }
}
```

### Standard Logic App

```hcl
module "logic_app" {
  source = "./terraform-azurerm-logic-app"

  name                = "la-myworkflow-eastus2-dev"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  kind                = "standard"
  storage_account_name = "stlamyworkflowdev"
  identity_type        = "SystemAssigned"

  tags = {
    environment = "dev"
  }
}
```

### Standard Logic App with existing App Service Plan

```hcl
module "logic_app" {
  source = "./terraform-azurerm-logic-app"

  name                 = "la-myworkflow-eastus2-dev"
  resource_group_name  = azurerm_resource_group.example.name
  location             = azurerm_resource_group.example.location
  kind                 = "standard"
  storage_account_name = "stlamyworkflowdev"
  app_service_plan_id  = azurerm_service_plan.existing.id

  tags = {
    environment = "dev"
  }
}
```
