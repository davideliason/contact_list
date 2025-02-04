variable "name" {}
variable "ami" { default = "ami-0c55b159cbfafe1f0" }

variable "instance_type" { default = "t2.micro" }
variable "key_name" { default = "best-dir" }
variable "associate_public_ip_address" { default = true }
variable "user_data" { default = "" }


variable "vpc_id" {}
variable "subnet_ids" {}
variable "security_group_ids" {}
variable "tags" { default = {} }
