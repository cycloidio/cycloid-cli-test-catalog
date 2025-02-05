module "compute" {
  #####################################
  # Do not modify the following lines #
  source    = "./module-compute"
  project   = var.project
  env       = var.env
  org       = var.org
  component = var.component
  #####################################

  #. extra_tags (optional): {}
  #+ Dict of extra tags to add on resources. format { "foo" = "bar" }.
  extra_tags = {
    demo                 = true
    monitoring_discovery = false
  }

  #
  # Instance
  #

  #. vm_instance_type: 't3.micro'
  #+ Instance type for the VM
  vm_instance_type = "Value injected by StackForms"

  #. vm_disk_size: 20
  #+ Disk size for the VM (Go)
  vm_disk_size = "Value injected by StackForms"

  #. vpc_id: ''
  #+ VPC ID where to deploy the EC2 instance
  vpc_id = "Value injected by StackForms"

  #. key_pair_name: ''
  #+ Public Key pair name to provision to the EC2 instance
  # key_pair_name = "Value injected by StackForms"
}
