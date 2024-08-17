# VPC CIDR range
variable "vpcCidr" {
  default     = "10.1.0.0/16"
  type        = string
  description = "VPC nonprod CIDR"
}

# Public subnet CIDR ranges in VPC
variable "publicCidrBlocks" {
  default     = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24", "10.1.4.0/24"]
  type        = list(string)
  description = "Public Subnet CIDRs in non prod VPC"
}

# Private subnet CIDR ranges in VPC
variable "privateCidrBlocks" {
  default     = ["10.1.5.0/24", "10.1.6.0/24"]
  type        = list(string)
  description = "Private subnet CIDR ranges in non prod VPC"
}

# Default Tags
variable "defaultTags" {
  default = {
    "Owner" = "Hongwei"
    "App"   = "Web"
  }
  type        = map(any)
  description = "Default tags to be appliad to all AWS resources"
}

# Prefix to identify resources
variable "prefix" {
  default     = "finalProject"
  type        = string
  description = "Name prefix"
}

# variable to signal the current environment
variable "env" {
  default     = "prod"
  type        = string
  description = "Production Environment"
}