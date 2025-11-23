variable "environment" {
  description = "The environment for the deployment (e.g., dev, test, prod)"
  type        = string
  default     = "prod"

  validation {
    condition     = contains(["dev", "test", "prod"], var.environment)
    error_message = "environment must be one of: dev, test, prod."
  }
}