variable "namespace" {}

variable "zone" {}

variable "network_name" {
  description = "name of the network to attach the instance to"
}

variable "instance_type" {
  description = "Instance type to use when creating servers and nodes e.g 1-standard-1n"
  default     = "1-standard-1n"
}

variable "source_image" {
  description = "Base image to use when creating instances"
  default     = "ubuntu-os-cloud/ubuntu-1604-lts"
}

variable "min_instances" {
  description = "Minimum number of servers."
}

variable "max_instances" {
  description = "Maximum number of nomad servers."
}

# Consul configuration
variable "consul_enabled" {
  description = "Should consul be installed onto the instance?"
}

variable "consul_type" {
  description = "Is the consul instance a server or client"
}

variable "consul_version" {
  description = "Version number for nomad"
}

variable "consul_join_tag_key" {
  description = "AWS Tag to use for consul auto-join"
}

variable "consul_join_tag_value" {
  description = "Value to search for in auto-join tag to use for consul auto-join"
}

variable "consul_wan" {
  description = "Consul WAN address for joining clusters"
  default     = ""
}

# Nomad settings
variable "nomad_wan" {
  description = "Consul WAN address for joining clusters"
  default     = ""
}

variable "nomad_enabled" {
  description = "Is nomad enabled on this instance"
}

variable "nomad_type" {
  description = "Is nomad a server or an agent"
}

variable "nomad_version" {
  description = "Version number for nomad"
}

variable "nomad_consul_uri" {
  description = "Location of consul server for bootstrapping"
  default     = "http://localhost:8500"
}

variable "nomad_datacentre" {
  description = "Default datacenter for Nomad"
  default     = "dc1"
}

variable "nomad_region" {
  description = "Default datacenter for Nomad"
  default     = "gcp"
}

variable "key_name" {
  description = "The absolute path on disk to the SSH public key."
}
