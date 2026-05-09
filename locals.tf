locals {
  is_consumption      = var.kind == "consumption"
  is_standard         = var.kind == "standard"
  create_service_plan = local.is_standard && var.app_service_plan_id == null
}
