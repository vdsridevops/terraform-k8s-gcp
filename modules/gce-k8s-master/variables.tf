variable "project" {
  description = " Google Cloud Platform - Project "
  type = string
  default = "devopsbar20"
}

variable "region" {
  description = " Google Cloud Platform - Region "
  type = string
  default = "us-west1"
}

variable "machine_type" {
  description = " Machine type "
  type = string
  default = "n1-standard-2"
}

variable "zone" {
  description = " Zone "
  type = string
  default = "us-west1-a"
}

variable "image" {
  description = " Image "
  type = string
  default = "centos-7"
}

variable "instance_name" {
  description = "Instance Names"
  type = string
  default = "k8s-master"
}
variable "ip" {
  description = "IP Address"
  type = string
  default = "10.138.0.15"
}

variable "passwd" {
  description = "Password"
  type = string
  default = "ansible123"
}
