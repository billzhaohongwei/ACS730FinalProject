# VPC CIDR range
variable "vpcCidr" {
  type        = string
  description = "VPC CIDR range"
}

# Public subnet CIDR ranges
variable "publicCidrBlocks" {
  type        = list(string)
  description = "Public Subnet CIDRs in non prod VPC"
}

# Private subnet CIDR ranges
variable "privateCidrBlocks" {
  type        = list(string)
  description = "Private subnet CIDR ranges in prod VPC"
}


# Default Tags
variable "defaultTags" {
  type        = map(any)
  description = "Default tags to be applied to all AWS resources"
}

#Prefix to identify resources
variable "prefix" {
  type        = string
  description = "Name prefix"
}

#variable to signal the current environment
variable "env" {
  type        = string
  description = "Deployment Environment"
}
