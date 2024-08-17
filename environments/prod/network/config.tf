terraform {
  backend "s3" {
    bucket = "prod-acs730-final-hongweizhao" // Bucket where to SAVE Terraform State. Please provide your custom unique name
    key    = "network/terraform.tfstate"     // Object name in the bucket to SAVE Terraform State
    region = "us-east-1"                     // Region where bucket is created
  }
}