resource "yandex_kubernetes_node_group" "node_group" {
  for_each = var.resources_nodes
  cluster_id  = "${yandex_kubernetes_cluster.kuber-cluster.id}"
  name        = each.key
  description = "nodes for kubernetes"
  version     = var.kub_version
  depends_on = [yandex_kubernetes_cluster.kuber-cluster]

#  labels = {
#    "key" = "value"
#  }

  instance_template {

    platform_id = lookup(each.value, "platform_id", null)
    name = lookup(each.value, "name", null)

    network_interface {
      nat                = lookup(each.value, "nat", true)
      subnet_ids         = [for k in yandex_vpc_subnet.subnet-main : k.id]
      security_group_ids = [yandex_vpc_security_group.k8s_worker.id, yandex_vpc_security_group.internal.id]

    }

    resources {
      memory = lookup(each.value, "memory", 4)
      cores  = lookup(each.value, "cores", 2)
      core_fraction = lookup(each.value, "core_fraction", 50)
    }

    boot_disk {
      type = lookup(each.value, "boot_disk_type", "network-hdd")
      size = lookup(each.value, "boot_disk_size", 32)
    }

    scheduling_policy {
      preemptible = lookup(each.value, "preemptible", false)
    }
  }

  scale_policy {
    fixed_scale {
      size = lookup(each.value, "fixed_scale", 3)
    }
  }

  allocation_policy {
     dynamic "location" {
       for_each = {for key, n in yandex_vpc_subnet.subnet-main : n.name => n}
       content {
         zone      = location.value.zone
       }

     }
  }
}