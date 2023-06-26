resource "yandex_vpc_network" "network" {
  name = "network01"
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

resource "yandex_vpc_subnet" "subnet" {
  for_each       = var.subnets
  name           = each.key
  v4_cidr_blocks = each.value.v4_cidr_blocks
  zone           = "ru-central1-${each.value.zone}"
  network_id     = yandex_vpc_network.network.id
  route_table_id = yandex_vpc_route_table.rt.id
}




