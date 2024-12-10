 # Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}

client_id           ="${var.client_id}"
client_secret       ="${var.client_secret}"
subscription_id     = "${var.subscription_id}"
tenant_id           = "${var.tenant_id}"
 
}
variable "client_id" {
  description = "Enter client id for application created in Azure AD"
}

variable "client_secret" {
  description = "Enter client secret for application created in Azure AD"
  }

variable "subscription_id" {
  description = "Enter subscription id for resoures provising in Azure"
}

variable "tenant_id" {
    description = "Enter tennat id/Directory id of your azure ad. Get-Azuresubscription"
  
}
variable "billing_account_name" {
    description = "billing account name"
}
variable "billing_profile_name" {
  description = "billing profile name"
}
variable "invoice_section_name" {
  description = "invoice section name"
}