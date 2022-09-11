variable "billing_account" {
  type        = string
  description = "Billing account to associate with the project being created."
}

variable "region" {
  type        = string
  description = "Default region to use for the project"
  default     = "us-central1"
}

variable "zone" {
  type        = string
  description = "Default region to use for the project"
  default     = "us-central1-a"
}