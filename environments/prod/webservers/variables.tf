# VPC ID
variable "vpcId" {
  default     = ""
  type        = string
  description = "VPC ID"
}


# Instance Type
variable "instance_type" {
  default = {
    "prod"    = "t3.micro"
    "nonprod" = "t2.micro"
  }
  type        = map(string)
  description = "Type of EC2 instance"
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
variable "key_name" {
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