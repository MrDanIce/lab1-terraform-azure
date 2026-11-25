variable "location" {
  description = "Azure region."
  type        = string
  default     = "westus2"
}

variable "vm_size" {
  description = "VM size. Confirm free eligibility and regional availability first."
  type        = string
  default     = "Standard_B2pts_v2"
}

variable "admin_username" {
  description = "Linux admin user."
  type        = string
  default     = "labadmin"
}

variable "ssh_public_key" {
  description = "SSH public key text. Required by Azure; the VM has no public IP."
  type        = string
  sensitive   = true
}

variable "alert_email" {
  description = "Address for CPU alerts."
  type        = string
  sensitive   = true
}

variable "cpu_threshold" {
  description = "Average CPU percent that fires the alert."
  type        = number
  default     = 70
}
