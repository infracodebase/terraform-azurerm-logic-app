# Azure Logic App Module
#
# Supports both Consumption (azurerm_logic_app_workflow) and Standard
# (azurerm_logic_app_standard) Logic Apps, selected via the kind variable.

# -----------------------------------------------------------------------------
# Consumption Logic App
# -----------------------------------------------------------------------------

resource "azurerm_logic_app_workflow" "this" {
  count = local.is_consumption ? 1 : 0

  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  workflow_parameters = var.workflow_parameters

  dynamic "identity" {
    for_each = var.identity_type != null ? [1] : []

    content {
      type         = var.identity_type
      identity_ids = contains(["UserAssigned", "SystemAssigned, UserAssigned"], var.identity_type) ? var.identity_ids : null
    }
  }

  tags = var.tags
}

# -----------------------------------------------------------------------------
# Standard Logic App
# -----------------------------------------------------------------------------

resource "azurerm_storage_account" "this" {
  count = local.is_standard ? 1 : 0

  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = var.storage_account_replication_type

  tags = var.tags

  lifecycle {
    precondition {
      condition     = var.storage_account_name != null
      error_message = "The storage_account_name variable is required when kind is 'standard'."
    }
  }
}

resource "azurerm_service_plan" "this" {
  count = local.create_service_plan ? 1 : 0

  name                = "${var.name}-plan"
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = "Windows"
  sku_name            = var.app_service_plan_sku_name

  tags = var.tags
}

resource "azurerm_logic_app_standard" "this" {
  count = local.is_standard ? 1 : 0

  name                       = var.name
  resource_group_name        = var.resource_group_name
  location                   = var.location
  app_service_plan_id        = local.create_service_plan ? azurerm_service_plan.this[0].id : var.app_service_plan_id
  storage_account_name       = azurerm_storage_account.this[0].name
  storage_account_access_key = azurerm_storage_account.this[0].primary_access_key
  app_settings               = var.app_settings
  virtual_network_subnet_id  = var.virtual_network_subnet_id
  public_network_access      = var.public_network_access_enabled ? "Enabled" : "Disabled"
  https_only                 = var.https_only

  site_config {
    # Enforce a minimum TLS version for inbound connections to the Logic App.
    min_tls_version = var.min_tls_version
  }

  dynamic "identity" {
    for_each = var.identity_type != null ? [1] : []

    content {
      type         = var.identity_type
      identity_ids = contains(["UserAssigned", "SystemAssigned, UserAssigned"], var.identity_type) ? var.identity_ids : null
    }
  }

  tags = var.tags
}

# -----------------------------------------------------------------------------
# Diagnostic Settings
# -----------------------------------------------------------------------------

resource "azurerm_monitor_diagnostic_setting" "this" {
  count = var.log_analytics_workspace_id != null ? 1 : 0

  name                       = var.diagnostic_setting_name != null ? var.diagnostic_setting_name : "${var.name}-diag"
  target_resource_id         = local.is_consumption ? azurerm_logic_app_workflow.this[0].id : azurerm_logic_app_standard.this[0].id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  enabled_log {
    category_group = "allLogs"
  }

  enabled_metric {
    category = "AllMetrics"
  }
}
