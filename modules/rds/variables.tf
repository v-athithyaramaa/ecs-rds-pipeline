variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "List of private subnet IDs for RDS"
}

variable "environment" {
  type        = string
  description = "Environment name"
}

variable "db_password" {
  type        = string
  description = "Database master password"
  sensitive   = true
}
