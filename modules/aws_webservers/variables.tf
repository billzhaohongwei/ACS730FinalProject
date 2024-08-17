# Instance Type
variable "instance_type" {
  default = {
  }
  type        = map(string)
  description = "Type of EC2 instance"
}


# Default Tags
variable "default_tags" {
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
variable "key_name" {
  type        = string
  description = "SSH key pair's name"
}

variable "s3_bucket_name" {
  #  default     = "acs730-lab4-hongwei"
  type        = string
  description = "S3 bucket name for remote state to use"
}
variable "s3_obj_keyname" {
  #  default     = "dev/network/terraform.tfstate"
  type        = string
  description = "S3 object key name for remote state to use"
}

