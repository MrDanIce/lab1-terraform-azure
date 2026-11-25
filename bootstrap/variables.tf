variable "location" {
  description = "Azure region."
  type        = string
  default     = "westus2"
}

variable "github_repo" {
  description = "GitHub repository allowed to run plans, as owner@ownerID/name@repoID (immutable OIDC subject)."
  type        = string
}

variable "budget_email" {
  description = "Address for budget alerts."
  type        = string
  sensitive   = true
}

variable "budget_amount" {
  description = "Monthly budget in the billing currency. A budget alerts; it does not stop spending."
  type        = number
  default     = 10
}

variable "budget_start_date" {
  description = "First day of the current month, for example 2026-11-01T00:00:00Z."
  type        = string
}
