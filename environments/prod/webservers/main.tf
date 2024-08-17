# Define the provider
provider "aws" {
  region = "us-east-1"
}
# Use remote state to retrieve the data from state file of networking
data "terraform_remote_state" "remoteState" { // This is to use Outputs from Remote State
  backend = "s3"
  config = {
    bucket = var.s3BucketName // Bucket from where to GET Terraform State
    key    = var.s3ObjKeyname // Object name in the bucket to GET Terraform State
    region = "us-east-1"      // Region where bucket created
  }
}

# reference the security group module
module "securityGroup" {
  source = "../../../modules/aws_sg"

  # pass arguments
  prefix      = var.prefix
  env         = var.env
  defaultTags = var.defaultTags
  vpcId       = data.terraform_remote_state.remoteState.outputs.vpcId
  //  s3BucketName = var.s3BucketName
  //  s3ObjKeyname = var.s3ObjKeyname


  /*
>>>>>>>>> local version
  instance_type  = var.instance_type
  key_name       = var.key_name
  */
}

# reference the webserver module
module "webServer" {
  source = "../../../modules/aws_webservers"

  # pass arguments
  prefix           = var.prefix
  env              = var.env
  defaultTags      = var.defaultTags
  instanceType     = var.instanceType
  keyName          = var.keyName
  webServerSgId    = module.securityGroup.webServerSgId
  vmSgId           = module.securityGroup.vmSgId
  publicSubnetIds  = data.terraform_remote_state.remoteState.outputs.publicSubnetId
  privateSubnetIds = data.terraform_remote_state.remoteState.outputs.privateSubnetId


  /*
>>>>>>>>> local version
  instance_type  = var.instance_type
  key_name       = var.key_name
  */
}