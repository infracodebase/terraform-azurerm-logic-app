# Tests for Standard Logic App configuration

variables {
  name                 = "la-test-standard"
  resource_group_name  = "rg-test"
  location             = "eastus2"
  kind                 = "standard"
  storage_account_name = "stteststandard"

  tags = {
    environment = "test"
  }
}

run "standard_creates_all_resources" {
  command = plan

  assert {
    condition     = azurerm_logic_app_standard.this[0].name == "la-test-standard"
    error_message = "Standard Logic App name does not match expected value."
  }

  assert {
    condition     = azurerm_storage_account.this[0].name == "stteststandard"
    error_message = "Storage Account name does not match expected value."
  }

  assert {
    condition     = azurerm_service_plan.this[0].name == "la-test-standard-plan"
    error_message = "Service Plan name does not match expected value."
  }

  assert {
    condition     = azurerm_service_plan.this[0].os_type == "Windows"
    error_message = "Service Plan OS type should be Windows."
  }

  assert {
    condition     = length(azurerm_logic_app_workflow.this) == 0
    error_message = "Consumption Logic App should not be created when kind is 'standard'."
  }
}

run "standard_with_existing_plan" {
  command = plan

  variables {
    app_service_plan_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-test/providers/Microsoft.Web/serverfarms/existing-plan"
  }

  assert {
    condition     = length(azurerm_service_plan.this) == 0
    error_message = "Service Plan should not be created when app_service_plan_id is provided."
  }

  assert {
    condition     = azurerm_logic_app_standard.this[0].app_service_plan_id == "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-test/providers/Microsoft.Web/serverfarms/existing-plan"
    error_message = "Should use the provided App Service Plan ID."
  }
}

run "standard_with_custom_sku" {
  command = plan

  variables {
    app_service_plan_sku_name = "WS2"
  }

  assert {
    condition     = azurerm_service_plan.this[0].sku_name == "WS2"
    error_message = "Service Plan SKU should match the provided value."
  }
}
