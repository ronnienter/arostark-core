variable "project_name" {
  description = "Project name used for tagging all resources"
  type        = string
  default     = "arostark-core"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}