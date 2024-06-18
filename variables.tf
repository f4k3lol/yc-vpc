variable "name" {
  type = string
}

variable "subnets" {
  type = map(any)
}

variable "external_addresses" {
  type    = map(any)
  default = {}
}