
#create a 3-resourcegroup, 3-storage, 3-container, 3-blob 

variable "resource_group" {
  type = map(object({
    resource_group_name=string
    location = string
    
  }
  )
  )

  default = {
    "rg1"={
      resource_group_name="rg-shuaib1"
      location ="east us"
    },
      
    "rg2"={
      resource_group_name="rg-shuaib2"
      location ="west us"
    },

    "rg3"={
      resource_group_name="rg-shuaib3"
      location ="west europe"
    }
    }
  }

#Create a new subscription

data "azurerm_billing_enrollment_account_scope" "Account-Shuaib" {
  billing_account_name    = "b5b0fc26-4c03-5e09-7185-11ef09f994d7:5ab32e97-4e83-4db0-8d54-81fe2b0154a3_2019-05-31"
  enrollment_account_name = "SUCH-VR35-BG7-PGB"
}

resource "azurerm_subscription" "Subscription-Shuaib" {
  subscription_name = "Zalando-Shuaib"
  billing_scope_id  = data.azurerm_billing_enrollment_account_scope.Account-Shuaib.id
}

#Create a Three resource groups
resource "azurerm_resource_group" "rg" {
  for_each = var.resource_group
  name =each.value.resource_group_name
  location = each.value.location
  depends_on = [ azurerm_subscription.Subscription-Shuaib ]
}