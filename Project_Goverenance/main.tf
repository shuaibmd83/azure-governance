
# Configure the Microsoft Azure Provider


data "azurerm_billing_mca_account_scope" "billing" {
  billing_account_name = var.billing_account_name
  billing_profile_name = var.billing_profile_name
  invoice_section_name = var.invoice_section_name
  
}
#create a subscription
resource "azurerm_subscription" "nonprd_hub" {
  subscription_name = "nonprd-hub"
  billing_scope_id  = data.azurerm_billing_mca_account_scope.billing.id
depends_on = [ data.azurerm_billing_mca_account_scope.billing ]
}

#role assignement as owner to create resources
data "azurerm_subscription" "nonprd_hub" {}

resource "azurerm_role_assignment" "shuaib" {
  scope                = data.azurerm_subscription.nonprd_hub.id
  role_definition_name = "owner"
  principal_id         = "96a47f39-999f-41a6-9723-1d04066fafb5"

}

# Create a Resource Group
resource "azurerm_resource_group" "Paid" {
  name     = "PAYG"
  location = "West Europe"
  depends_on = [ azurerm_subscription.nonprd_hub ]
}

resource "azurerm_log_analytics_workspace" "Paid-Workspace" {
  name                = "PAYG-workspace"
  location            = azurerm_resource_group.Paid.location
  resource_group_name = azurerm_resource_group.Paid.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  depends_on = [ data.azurerm_subscription.nonprd_hub ]
}
data "azurerm_subscription" "Pay-As-You-Go" {
}

resource "azurerm_monitor_diagnostic_setting" "PAYG-diagnostic" {
  name               = "AllLogs_PayAsYouGo"
  target_resource_id = data.azurerm_subscription.Pay-As-You-Go.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.Paid-Workspace.id
  log_analytics_destination_type = "AzureDiagnostics"
  
log {
    category = "Administrative"
    enabled  = true
  }

  metric {
    category = "AllMetrics"
    enabled  = true
  }
}
 

# resource "azurerm_subscription" "nonprd_spk" {
#   subscription_name = "nonprd-spoke"
#   billing_scope_id  = data.azurerm_billing_mca_account_scope.billing.id
# }

# resource "azurerm_subscription" "prd_spk" {
#   subscription_name = "prd-spoke"
#   billing_scope_id  = data.azurerm_billing_mca_account_scope.billing.id
# }