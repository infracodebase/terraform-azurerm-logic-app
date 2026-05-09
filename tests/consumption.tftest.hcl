# Tests for Consumption Logic App configuration

variables {
  name                = "la-test-consumption"
  resource_group_name = "rg-test"
  location            = "eastus2"
  kind                = "consumption"

  tags = {
    environment = "test"
  }
}

run "consumption_creates_workflow" {
  command = plan

  assert {
    condition     = azurerm_logic_app_workflow.this[0].name == "la-test-consumption"
    error_message = "Logic App workflow name does not match expected value."
  }

  assert {
    condition     = azurerm_logic_app_workflow.this[0].location == "eastus2"
    error_message = "Logic App workflow location does not match expected value."
  }

  assert {
    condition     = length(azurerm_logic_app_standard.this) == 0
    error_message = "Standard Logic App should not be created when kind is 'consumption'."
  }

  assert {
    condition     = length(azurerm_storage_account.this) == 0
    error_message = "Storage Account should not be created when kind is 'consumption'."
  }

  assert {
    condition     = length(azurerm_service_plan.this) == 0
    error_message = "Service Plan should not be created when kind is 'consumption'."
  }
}

run "consumption_with_identity" {
  command = plan

  variables {
    identity_type = "SystemAssigned"
  }

  assert {
    condition     = azurerm_logic_app_workflow.this[0].identity[0].type == "SystemAssigned"
    error_message = "Identity type should be SystemAssigned."
  }
}
