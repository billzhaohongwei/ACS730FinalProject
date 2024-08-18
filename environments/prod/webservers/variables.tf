# VPC ID
variable "vpcId" {
  default     = ""
  type        = string
  description = "VPC ID"
}

# Instance Type
variable "instanceType" {
  default = {
    "Prod"    = "t2.micro"
    "Dev"     = "t2.micro"
    "Staging" = "t2.micro"
  }
  type        = map(string)
  description = "Type of EC2 instance"
}

variable "publicSubnetIds" {
  default     = []
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "privateSubnetIds" {
  default     = []
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "elbSubnetIds" {
  default     = []
  description = "A list of subnet IDs to attach to the load balancer."
  type        = list(string)
}

variable "elbInstanceIds" {
  default     = []
  description = "A list of instance IDs to attach to the load balancer."
  type        = list(string)
}

variable "vmSgId" {
  default     = ""
  type        = string
  description = "private subnet vm's security group ID"
}

variable "webServerSgId" {
  default     = ""
  type        = string
  description = "public web server security group ID"
}

variable "elbSgId" {
  default     = ""
  type        = string
  description = "elastic load balancer security group ID"
}

# Default Tags
variable "defaultTags" {
  default = {
    "Owner" = "Hongwei"
    "App"   = "Web"
  }
  type        = map(any)
  description = "Default tags to be applied to all AWS resources"
}

#Prefix to identify resources
variable "prefix" {
  default     = "finalProject"
  type        = string
  description = "Name prefix"
}

#variable to signal the current environment
variable "env" {
  default     = "Prod"
  type        = string
  description = "Production Environment"
}


#variable to declare keyname
variable "keyName" {
  default     = "final"
  type        = string
  description = "SSH key pair's name"
}

variable "s3BucketName" {
  default     = "prod-acs730-final-hongweizhao"
  type        = string
  description = "S3 bucket name for remote state to use"
}
variable "s3ObjKeyname" {
  default     = "network/terraform.tfstate"
  type        = string
  description = "S3 object key name for remote state to use"
}