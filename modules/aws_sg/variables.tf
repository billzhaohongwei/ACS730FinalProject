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
