resource "yandex_vpc_network" "network" {
  name = var.name
}

resource "yandex_vpc_gateway" "nat_gw" {
  shared_egress_gateway {}
}

resource "yandex_vpc_route_table" "rt" {
  network_id = yandex_vpc_network.network.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.nat_gw.id
  }
}

resource "yandex_vpc_subnet" "this" {
  for_each       = var.subnets
  name           = each.key
  v4_cidr_blocks = each.value.v4_cidr_blocks
  zone           = "ru-central1-${each.value.zone}"
  network_id     = yandex_vpc_network.network.id
  route_table_id = yandex_vpc_route_table.rt.id
}

resource "yandex_vpc_address" "this" {
  for_each    = var.external_addresses
  name        = each.key
  description = lookup(each.value, "description", null)

  external_ipv4_address {
    zone_id                  = "ru-central1-${each.value.zone}"
    ddos_protection_provider = lookup(each.value, "ddos_protection_provider", null)
  }
}