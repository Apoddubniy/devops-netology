
resource "yandex_vpc_network" "network-main" {
  name = var.network_name
}

resource "yandex_vpc_subnet" "subnet-main" {
  for_each       = {for key, n in var.subnets : n.name => n}
  network_id     = yandex_vpc_network.network-main.id
  v4_cidr_blocks = each.value.cidr
  zone           = each.value.zone
  name           = each.value.name
}