variable "location" {
  default     = "Westus"
  description = "This is the location where all resources will be located"
  type        = string
}

variable "ssh_public_key" {
  default     = "C:/Users/consultant/armstorageacc/smalldeploy/aksprodsskeys.pub"
  description = "This variable defines the SSH public key for Linux K8s"
  type        = string
}

variable "windows_admin_username" {
  type        = string
  default     = "personal4slim"
  description = "This variable defines the Windows admin username for K8s"
}

variable "windows_admin_password" {
  type        = string
  default     = "Oluwaseun_101#"
  description = "This variable defines the Windows admin password for K8s"
}

variable "environment" {
  type        = string
  default     = "production" # Provide the appropriate default value
  description = "This variable defines the environment for your resources"
}