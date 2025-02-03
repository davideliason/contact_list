variable "vpc_name" {} # since no default given, this var is required- a value must be passed when calling the module or TF apply
variable "cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.16.0.0/16"
}
variable "azs" { default = [] } # an empty default is provided so no AZ used in one isn't provided
variable "public_subnets" { default = [] }
variable "private_subnets" { default = [] }
variable "tags" { default = {} }
