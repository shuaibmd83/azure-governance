
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


#Create resource group
resource "azurerm_resource_group" "rg" {
  for_each = var.resource_group
  name =each.value.resource_group_name
  location = each.value.location
  
}