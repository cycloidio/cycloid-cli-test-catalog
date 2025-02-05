# Cycloid
variable "component" {}
variable "org" {}
variable "env" {}
variable "project" {}

variable "key_pair_name" {
  description = "Public key to provision to the instance."
  default     = ""
}

variable "key_pair_public" {
  description = "Public key to create."
  default     = ""
}

# Tags
variable "extra_tags" {
  default = {}
}

locals {
  standard_tags = {
    "cycloid" = "true"
    component = var.component
    env       = var.env
    project   = var.project
    org       = var.org
  }
  merged_tags = merge(local.standard_tags, var.extra_tags)
}

