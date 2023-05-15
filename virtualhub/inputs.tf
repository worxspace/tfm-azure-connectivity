variable "hub-name" {
  type        = string
  description = "name of the virtual hub"
}

variable "resource-group-name" {
  type        = string
  description = "name of the resource group where the virtual hub is created"
}

variable "virtual-wan-id" {
  type        = string
  description = "id of the virtual wan where the virtual hub is created"
}

variable "location" {
  type        = string
  description = "location of the virtual hub"
}

variable "address-space" {
  type        = string
  description = "address space of the virtual hub"
}

variable "vnets" {
  type = list(object({
    name = string
    id   = string
  }))
  description = "list of virtual networks to be connected to the virtual hub"
}

variable "vpn-sites" {
  type = list(object({
    name          = string
    address-space = optional(list(string), null)
    links = list(object({
      name     = string
      ip       = string
      provider = string
      speed    = string
      bgp = optional(object({
        asn                 = number
        bgp_peering_address = string
      }), null)
    }))
  }))
  default     = []
  description = "list of vpn sites to be connected to the virtual hub"
}

variable "global-tags" {
  type        = map(string)
  description = "global tags to be added to all resources"
}
