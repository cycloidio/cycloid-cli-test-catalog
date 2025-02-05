module "network" {
  #####################################
  # Do not modify the following lines #
  source    = "./network"
  component = var.component
  project   = var.project
  env       = var.env
  org       = var.org
  #####################################

  #. extra_tags (optional): {}
  #+ Dict of extra tags to add on resources. format { "foo" = "bar" }.
  extra_tags = {
    demo                 = true
    monitoring_discovery = false
  }

  #. vpc_cidr: "10.0.0.0/16"
  #+ Public Subnet CIDR
  vpc_cidr = "10.0.0.0/16"

  #. vpc_public_subnet: "10.0.0.0/24"
  #+ Public Subnet CIDR
  vpc_public_subnet = "10.0.0.0/24"

  #. vpc_private_subnet: "10.0.1.0/24"
  #+ Private Subnet CIDR
  vpc_private_subnet = "10.0.1.0/24"

  #. nat_gateway: false
  #+ Whether to deploy a NAT gateway or not
  nat_gateway = false
}

# module "key_pair" {
#   #####################################
#   # Do not modify the following lines #
#   source    = "./key_pair"
#   component = var.component
#   project   = var.project
#   env       = var.env
#   org  = var.org
#   #####################################
# 
#   #. extra_tags (optional): {}
#   #+ Dict of extra tags to add on resources. format { "foo" = "bar" }.
#   extra_tags = {
#     demo                 = true
#     monitoring_discovery = false
#   }
# 
#   #. key_pair_name: ""
#   #+ The name of the key pair to provision to the instance
#   key_pair_name = "${var.org}-${var.project}-${var.env}-${var.component}"
# 
#   #. key_pair_public: ""
#   #+ Public key to create
#   key_pair_public = "Value injected by StackForms"
# }

