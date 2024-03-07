variable "resource_group_name" {
  description = "The name of the resource group in which to create the virtual network gateway."
  type        = string
}

variable "location" {
  description = "The location/region where the virtual network gateway will be created."
  type        = string
}

variable "name" {
  description = "The name of the virtual network gateway."
  type        = string
}

variable "sku" {
  description = "The SKU of the virtual network gateway."
  type        = string
}

variable "type" {
  description = "The type of the virtual network gateway."
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet in which to create the virtual network gateway."
  type        = string
}

variable "public_ip" {
  description = "The public IP address configuration for the virtual network gateway."
  type = object({
    name              = optional(string, null)
    allocation_method = optional(string, "Dynamic")
    sku               = optional(string, "Basic")
    tags              = optional(map(string), {})
  })
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
}

variable "vpn_point_to_site" {
  description = "The VPN Point-to-Site configuration for the virtual network gateway."
  type = object({
    address_space         = list(string)
    aad_tenant            = optional(string, null)
    aad_audience          = optional(string, null)
    aad_issuer            = optional(string, null)
    radius_server_address = optional(string, null)
    radius_server_secret  = optional(string, null)
    vpn_client_protocols  = optional(list(string), null)
    vpn_auth_types        = optional(list(string), null)
    certificate = optional(object({
      name                  = string
      organization          = string
      validity_period_hours = number
    }), null)
    clients         = optional(list(string), null)
    revoked_clients = optional(list(string), null)
  })
}
