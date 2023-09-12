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
  default     = "production"
  description = "This variable defines the environment for your resources"
}

variable "node_count" {
  type        = number
  default     = 3
  description = "This variable defines the number of nodes in your cluster"
}

variable "vm_size" {
  type        = string
  default     = "Standard_D2s_v3"
  description = "This variable defines the VM size for your cluster nodes"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "This variable defines tags for your resources"
}

variable "cluster_name" {
  type        = string
  description = "Name of the AKS cluster"
}

variable "windows_admin_password" {
  type        = string
  default     = "Oluwaseun_101#"
  description = "This variable defines the Windows admin password for K8s"
}

variable "environment" {
  type        = string
  default     = "production"
  description = "This variable defines the environment for your resources"
}

variable "node_count" {
  type        = number
  default     = 3  # Provide an appropriate default value
  description = "This variable defines the number of nodes in your cluster"
}

variable "vm_size" {
  type        = string
  default     = "Standard_D2s_v3"  # Provide an appropriate default value
  description = "This variable defines the VM size for your cluster nodes"
}

variable "tags" {
  type        = map(string)
  default     = {}  # Provide an appropriate default value as a map
  description = "This variable defines tags for your resources"
}
