# VPC CIDR range
variable "vpcId" {
  type        = string
  description = "VPC ID"
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

/*
variable "s3BucketName" {
  type        = string
  description = "S3 bucket name for remote state to use"
}

variable "s3ObjKeyname" {
  type        = string
  description = "S3 object key name for remote state to use"
}
*/