# terraform-azurerm-logic-app

Terraform module for Azure Logic Apps supporting both Consumption and Standard tiers.

## Usage

### Consumption Logic App

```hcl
module "logic_app" {
  source = "infracodebase/logic-app/azurerm"

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
  source = "infracodebase/logic-app/azurerm"

  name                 = "la-myworkflow-eastus2-dev"
  resource_group_name  = azurerm_resource_group.example.name
  location             = azurerm_resource_group.example.location
  kind                 = "standard"
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
  source = "infracodebase/logic-app/azurerm"

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

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_logic_app_standard.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/logic_app_standard) | resource |
| [azurerm_logic_app_workflow.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/logic_app_workflow) | resource |
| [azurerm_monitor_diagnostic_setting.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_service_plan.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_plan) | resource |
| [azurerm_storage_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_service_plan_id"></a> [app\_service\_plan\_id](#input\_app\_service\_plan\_id) | The ID of an existing App Service Plan. If not provided, a new plan will be created. Only used when kind is 'standard'. | `string` | `null` | no |
| <a name="input_app_service_plan_sku_name"></a> [app\_service\_plan\_sku\_name](#input\_app\_service\_plan\_sku\_name) | The SKU name for the App Service Plan when creating a new one. Only used when kind is 'standard' and app\_service\_plan\_id is not provided. | `string` | `"WS1"` | no |
| <a name="input_app_settings"></a> [app\_settings](#input\_app\_settings) | A map of application settings for the Standard Logic App. | `map(string)` | `{}` | no |
| <a name="input_diagnostic_setting_name"></a> [diagnostic\_setting\_name](#input\_diagnostic\_setting\_name) | The name of the diagnostic setting. Required when log\_analytics\_workspace\_id is provided. | `string` | `null` | no |
| <a name="input_https_only"></a> [https\_only](#input\_https\_only) | Whether the Standard Logic App requires HTTPS. Only used when kind is 'standard'. | `bool` | `true` | no |
| <a name="input_identity_ids"></a> [identity\_ids](#input\_identity\_ids) | A list of User Assigned Identity IDs. Required when identity\_type includes 'UserAssigned'. | `list(string)` | `[]` | no |
| <a name="input_identity_type"></a> [identity\_type](#input\_identity\_type) | The type of managed identity to assign. Valid values are 'SystemAssigned', 'UserAssigned', or 'SystemAssigned, UserAssigned'. | `string` | `null` | no |
| <a name="input_kind"></a> [kind](#input\_kind) | The kind of Logic App to create. Valid values are 'consumption' or 'standard'. | `string` | `"consumption"` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure region where the Logic App will be created. | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_id"></a> [log\_analytics\_workspace\_id](#input\_log\_analytics\_workspace\_id) | The ID of the Log Analytics Workspace to send diagnostic logs to. When set, a diagnostic setting is created for the Logic App. | `string` | `null` | no |
| <a name="input_min_tls_version"></a> [min\_tls\_version](#input\_min\_tls\_version) | The minimum supported TLS version for the Standard Logic App. Only used when kind is 'standard'. | `string` | `"1.2"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the Logic App. | `string` | n/a | yes |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Whether public network access is allowed for the Standard Logic App. Set to false to require private endpoints. Only used when kind is 'standard'. | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the Logic App. | `string` | n/a | yes |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | The name of the Storage Account to create for the Standard Logic App. Must be globally unique, 3-24 characters, lowercase alphanumeric only. Required when kind is 'standard'. | `string` | `null` | no |
| <a name="input_storage_account_replication_type"></a> [storage\_account\_replication\_type](#input\_storage\_account\_replication\_type) | The replication type for the Storage Account. Only used when kind is 'standard'. | `string` | `"LRS"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to all resources. | `map(string)` | `{}` | no |
| <a name="input_virtual_network_subnet_id"></a> [virtual\_network\_subnet\_id](#input\_virtual\_network\_subnet\_id) | The subnet ID for VNet integration. Only used when kind is 'standard'. | `string` | `null` | no |
| <a name="input_workflow_parameters"></a> [workflow\_parameters](#input\_workflow\_parameters) | A map of workflow parameters for the Consumption Logic App. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_access_endpoint"></a> [access\_endpoint](#output\_access\_endpoint) | The access endpoint of the Consumption Logic App. |
| <a name="output_connector_endpoint_ip_addresses"></a> [connector\_endpoint\_ip\_addresses](#output\_connector\_endpoint\_ip\_addresses) | The list of connector endpoint IP addresses for the Consumption Logic App. |
| <a name="output_connector_outbound_ip_addresses"></a> [connector\_outbound\_ip\_addresses](#output\_connector\_outbound\_ip\_addresses) | The list of connector outbound IP addresses for the Consumption Logic App. |
| <a name="output_default_hostname"></a> [default\_hostname](#output\_default\_hostname) | The default hostname of the Standard Logic App. |
| <a name="output_diagnostic_setting_id"></a> [diagnostic\_setting\_id](#output\_diagnostic\_setting\_id) | The ID of the diagnostic setting, if one was created. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Logic App. |
| <a name="output_identity"></a> [identity](#output\_identity) | The identity block of the Logic App, including principal\_id and tenant\_id. |
| <a name="output_kind"></a> [kind](#output\_kind) | The kind of Logic App that was created. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Logic App. |
| <a name="output_outbound_ip_addresses"></a> [outbound\_ip\_addresses](#output\_outbound\_ip\_addresses) | The outbound IP addresses of the Standard Logic App. |
| <a name="output_possible_outbound_ip_addresses"></a> [possible\_outbound\_ip\_addresses](#output\_possible\_outbound\_ip\_addresses) | The possible outbound IP addresses of the Standard Logic App. |
| <a name="output_service_plan_id"></a> [service\_plan\_id](#output\_service\_plan\_id) | The ID of the App Service Plan, if one was created by this module. |
| <a name="output_storage_account_id"></a> [storage\_account\_id](#output\_storage\_account\_id) | The ID of the Storage Account created for the Standard Logic App. |
| <a name="output_workflow_endpoint_ip_addresses"></a> [workflow\_endpoint\_ip\_addresses](#output\_workflow\_endpoint\_ip\_addresses) | The list of workflow endpoint IP addresses for the Consumption Logic App. |
| <a name="output_workflow_outbound_ip_addresses"></a> [workflow\_outbound\_ip\_addresses](#output\_workflow\_outbound\_ip\_addresses) | The list of workflow outbound IP addresses for the Consumption Logic App. |
<!-- END_TF_DOCS -->
