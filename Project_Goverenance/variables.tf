 # Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}

  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  tenant_id       = "${var.tenant_id}"
  subscription_id = "${var.subscription_id}"
}

variable "client_id" {
    description = "Enter Clinet ID for Application creted in Azure AD"
  
}
variable "client_secret" {
    description = "Enter Clinet sectet for Application creted in Azure AD"
}
variable "tenant_id" {
    description = "Enter Tenant ID /Directory ID of your Azure AD. Run Get-AzureSubscription"  
}
variable "subscription_id" {
    description = "enter subscription ID for provisioning resources in Azure"
}

