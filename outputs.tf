output "id" {
  value = yandex_vpc_network.network.id
}

output "subnets" {
  value = { for k, v in yandex_vpc_subnet.this : k => { id = v.id, zone = v.zone, cidr = v.v4_cidr_blocks[0] } }
}

output "external_addresses" {
  value = { for k, v in yandex_vpc_address.this : k => { id = v.id, zone = v.external_ipv4_address.0.zone_id, description = v.description, ip = v.external_ipv4_address.0.address } }
}