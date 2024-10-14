variable "resource_group_name" {
  description = "Name of the Resource Group"
  default     = "DevOpsResourceGroup"
}

variable "location" {
  description = "Azure Region"
  default     = "eastus"
}

variable "app_service_plan_name" {
  description = "Name of the App Service Plan"
  default     = "DevOpsAppServicePlan"
}

variable "app_name" {
  description = "Name of the Web App"
  default     = "erdia-devops-webapp"
}
