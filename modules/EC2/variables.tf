
variable "instance_name" {
  description = "The name to use for the instance"
  type        = string
  default = "Terraform EC2"
}

variable "region_name" {
  description = "The region to deploy the instance"
  type        = string
  default = "ap-south-1"
}

variable "availability_zone" {
  description = "The availability zone to deploy the instance"
  type        = string
  default = "ap-south-1a"
}