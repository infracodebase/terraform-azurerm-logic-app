# Common

output "id" {
  description = "The ID of the Logic App."
  value       = local.is_consumption ? azurerm_logic_app_workflow.this[0].id : azurerm_logic_app_standard.this[0].id
}

output "identity" {
  description = "The identity block of the Logic App, including principal_id and tenant_id."
  value       = local.is_consumption ? try(azurerm_logic_app_workflow.this[0].identity[0], null) : try(azurerm_logic_app_standard.this[0].identity[0], null)
}

output "kind" {
  description = "The kind of Logic App that was created."
  value       = var.kind
}

output "name" {
  description = "The name of the Logic App."
  value       = var.name
}

# Consumption

output "access_endpoint" {
  description = "The access endpoint of the Consumption Logic App."
  value       = local.is_consumption ? azurerm_logic_app_workflow.this[0].access_endpoint : null
}

output "connector_endpoint_ip_addresses" {
  description = "The list of connector endpoint IP addresses for the Consumption Logic App."
  value       = local.is_consumption ? azurerm_logic_app_workflow.this[0].connector_endpoint_ip_addresses : null
}

output "connector_outbound_ip_addresses" {
  description = "The list of connector outbound IP addresses for the Consumption Logic App."
  value       = local.is_consumption ? azurerm_logic_app_workflow.this[0].connector_outbound_ip_addresses : null
}

output "workflow_endpoint_ip_addresses" {
  description = "The list of workflow endpoint IP addresses for the Consumption Logic App."
  value       = local.is_consumption ? azurerm_logic_app_workflow.this[0].workflow_endpoint_ip_addresses : null
}

output "workflow_outbound_ip_addresses" {
  description = "The list of workflow outbound IP addresses for the Consumption Logic App."
  value       = local.is_consumption ? azurerm_logic_app_workflow.this[0].workflow_outbound_ip_addresses : null
}

# Standard

output "default_hostname" {
  description = "The default hostname of the Standard Logic App."
  value       = local.is_standard ? azurerm_logic_app_standard.this[0].default_hostname : null
}

output "outbound_ip_addresses" {
  description = "The outbound IP addresses of the Standard Logic App."
  value       = local.is_standard ? azurerm_logic_app_standard.this[0].outbound_ip_addresses : null
}

output "possible_outbound_ip_addresses" {
  description = "The possible outbound IP addresses of the Standard Logic App."
  value       = local.is_standard ? azurerm_logic_app_standard.this[0].possible_outbound_ip_addresses : null
}

output "service_plan_id" {
  description = "The ID of the App Service Plan, if one was created by this module."
  value       = local.create_service_plan ? azurerm_service_plan.this[0].id : null
}

output "storage_account_id" {
  description = "The ID of the Storage Account created for the Standard Logic App."
  value       = local.is_standard ? azurerm_storage_account.this[0].id : null
}
