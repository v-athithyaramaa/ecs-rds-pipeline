variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "public_subnet_id" {
  type        = string
  description = "Public Subnet ID for task deployment"
}

variable "environment" {
  type        = string
  description = "Environment name"
}
