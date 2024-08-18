variable "vpcId" {
  description = "The VPC ID where the load balancer will be deployed."
  type        = string
}

variable "elbSubnetIds" {
  description = "A list of subnet IDs to attach to the load balancer."
  type        = list(string)
}

variable "elbSgId" {
  description = "security group ID to assign to the load balancer."
  type        = string
}

variable "elbInstanceIds" {
  description = "A list of instance IDs to attach to the load balancer."
  type        = list(string)
}

variable "elb_name" {
  description = "The name of the load balancer."
  type        = string
  default     = "my-elb"
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
