# Generic
variable "instance_type" {
  default = "n1-standard-1"
}

variable "zone" {
  description = "Zone to launch instances into"
}

variable "namespace" {
  description = "Namespace for application, all resources will be prefixed with namespace"
}

variable "min_servers" {
  description = "The minimum number of servers to add to the autoscale group"
}

variable "max_servers" {
  description = "The maximum number of servers allowed in the autoscale group"
}

variable "min_agents" {
  description = "The minimum number of agents to add to the autoscale group"
}

variable "max_agents" {
  description = "The maximum number of agents allowed in the autoscale group"
}

# Networking
variable "vpc_id" {
  description = "Name of the network to attach instances to"
}

variable "key_name" {
  description = "SSH key to add to instances"
}

# Consul settings
variable "consul_version" {
  description = "Consul version to install"
}

variable "consul_join_tag_key" {
  description = "AWS Tag to use for consul auto-join"
}

variable "consul_join_tag_value" {
  description = "Value to search for in auto-join tag to use for consul auto-join"
}

variable "consul_enabled" {
  description = "Is consul enabled on this instance"
}

# Nomad settings
variable "nomad_datacentre" {
  description = "Default datacenter for Nomad"
  default     = "dc1"
}

variable "nomad_region" {
  description = "Default datacenter for Nomad"
  default     = "gcp"
}

variable "nomad_enabled" {
  description = "Is nomad enabled on this instance"
}

variable "nomad_version" {
  description = "Nomad version to install"
}
