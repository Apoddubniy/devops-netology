resource "yandex_vpc_security_group" "internal" {
  name        = "internal"
  description = "Группа для мастеров и воркеров"
  network_id  = yandex_vpc_network.network-main.id
  labels = {
    firewall = "yc_internal"
  }
  ingress {
    protocol          = "ANY"
    description       = "self"
    v4_cidr_blocks    = flatten([for k in yandex_vpc_subnet.subnet-main : k.v4_cidr_blocks])
    from_port         = 0
    to_port           = 65535
  }
  egress {
    protocol          = "ANY"
    description       = "self"
    v4_cidr_blocks    = flatten([for k in yandex_vpc_subnet.subnet-main : k.v4_cidr_blocks])
    from_port         = 0
    to_port           = 65535
  }
}

resource "yandex_vpc_security_group" "k8s_master" {
  name        = "k8s-master"
  description = "Доступ к api из интернета"
  network_id  = yandex_vpc_network.network-main.id
  labels = {
    firewall = "k8s-master"
  }
  ingress {
    protocol       = "TCP"
    description    = "access to api k8s"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 443
  }
  ingress {
    protocol       = "TCP"
    description    = "access to api k8s"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 6443
  }
  ingress {
    protocol          = "TCP"
    description       = "access to api k8s from Yandex lb"
    predefined_target = "loadbalancer_healthchecks"
    from_port         = 0
    to_port           = 65535
  }
}

resource "yandex_vpc_security_group" "k8s_worker" {
  name        = "k8s-worker"
  description = "Группа безопасности для воркеров"
  network_id  = yandex_vpc_network.network-main.id
  labels = {
    firewall = "k8s-worker"
  }
  ingress {
    protocol       = "ANY"
    description    = "any connections"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }
  egress {
    protocol       = "ANY"
    description    = "any connections"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }
}