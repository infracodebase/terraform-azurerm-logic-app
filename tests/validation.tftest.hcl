# Tests for input variable validation

run "invalid_kind_rejected" {
  command = plan

  variables {
    name                = "la-test"
    resource_group_name = "rg-test"
    location            = "eastus2"
    kind                = "invalid"
  }

  expect_failures = [
    var.kind,
  ]
}

run "invalid_storage_account_name_rejected" {
  command = plan

  variables {
    name                 = "la-test"
    resource_group_name  = "rg-test"
    location             = "eastus2"
    kind                 = "standard"
    storage_account_name = "INVALID-NAME!"
  }

  expect_failures = [
    var.storage_account_name,
  ]
}
