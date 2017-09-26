provider "google" {}

variable "namespace" {
  type = "string"
}

variable "region" {
  type = "string"
}

variable "aws_servers" {
  type = "list"
}

variable "num_servers" {
  default = "3"
}

variable "num_nodes" {
  default = "3"
}
