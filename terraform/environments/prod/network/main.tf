#Define the provider
provider "aws" {
  region = "us-east-1"
}

# reference the network module
module "my_module" {
  # state module pathway
  source = "../../../modules/aws_network"

  # pass arguments
  vpcCidr           = var.vpcCidr
  publicCidrBlocks  = var.publicCidrBlocks
  privateCidrBlocks = var.privateCidrBlocks
  prefix            = var.prefix
  env               = var.env
  defaultTags       = var.defaultTags
}

