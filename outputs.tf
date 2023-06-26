output "id" {
  value = yandex_vpc_network.network.id
}

output "subnets" {
  value = {for k, v in yandex_vpc_subnet.subnet : k => { id = v.id, zone = v.zone, cidr = v.v4_cidr_blocks[0] }}
}