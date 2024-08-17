# Instance Type
variable "instanceType" {
  default = {
  }
  type        = map(string)
  description = "Type of EC2 instance"
}

variable "publicSubnetIds" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "privateSubnetIds" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "vmSgId" {
  type        = string
  description = "private vm's security group ID"
}

variable "webServerSgId" {
  type        = string
  description = "public web server security group ID"
}

# Default Tags
variable "defaultTags" {
  default = {
  }
  type        = map(any)
  description = "Default tags to be appliad to all AWS resources"
}

#Prefix to identify resources
variable "prefix" {
  type        = string
  description = "Namespace prefix"
}

#variable to signal the current environment
variable "env" {
  type        = string
  description = "Deployment Environment or Stage"
}


#variable to declare keyname
variable "keyName" {
  type        = string
  description = "SSH key pair's name"
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
