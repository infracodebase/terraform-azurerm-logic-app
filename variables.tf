# Core

variable "kind" {
  type        = string
  description = "The kind of Logic App to create. Valid values are 'consumption' or 'standard'."
  default     = "consumption"

  validation {
    condition     = contains(["consumption", "standard"], var.kind)
    error_message = "The kind must be either 'consumption' or 'standard'."
  }
}

variable "location" {
  type        = string
  description = "The Azure region where the Logic App will be created."
}

variable "name" {
  type        = string
  description = "The name of the Logic App."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the Logic App."
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to assign to all resources."
  default     = {}
}

# Identity

variable "identity_ids" {
  type        = list(string)
  description = "A list of User Assigned Identity IDs. Required when identity_type includes 'UserAssigned'."
  default     = []
}

variable "identity_type" {
  type        = string
  description = "The type of managed identity to assign. Valid values are 'SystemAssigned', 'UserAssigned', or 'SystemAssigned, UserAssigned'."
  default     = null
}

# Standard-specific

variable "app_service_plan_id" {
  type        = string
  description = "The ID of an existing App Service Plan. If not provided, a new plan will be created. Only used when kind is 'standard'."
  default     = null
}

variable "app_service_plan_sku_name" {
  type        = string
  description = "The SKU name for the App Service Plan when creating a new one. Only used when kind is 'standard' and app_service_plan_id is not provided."
  default     = "WS1"
}

variable "app_settings" {
  type        = map(string)
  description = "A map of application settings for the Standard Logic App."
  default     = {}
}

variable "storage_account_name" {
  type        = string
  description = "The name of the Storage Account to create for the Standard Logic App. Must be globally unique, 3-24 characters, lowercase alphanumeric only. Required when kind is 'standard'."
  default     = null

  validation {
    condition     = var.storage_account_name == null || can(regex("^[a-z0-9]{3,24}$", var.storage_account_name))
    error_message = "The storage account name must be 3-24 characters, lowercase letters and numbers only."
  }
}

variable "storage_account_replication_type" {
  type        = string
  description = "The replication type for the Storage Account. Only used when kind is 'standard'."
  default     = "LRS"
}

# Consumption-specific

variable "workflow_parameters" {
  type        = map(string)
  description = "A map of workflow parameters for the Consumption Logic App."
  default     = {}
}
