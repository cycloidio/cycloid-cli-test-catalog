# Cycloid variables
variable "component" {}
variable "env" {}
variable "project" {}
variable "org" {}

# AWS variables
variable "aws_cred" {
  description = "Contains AWS access_key and secret_key"
}
variable "aws_region" {
  description = "AWS region where to create servers."
  default     = "eu-west-3"
}

