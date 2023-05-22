resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}


data "yandex_compute_image" "image" {
  family = var.image_family
}
  resource "yandex_compute_instance" "web" {
    name = local.name_suffix_web
    platform_id = var.platform
    resources {
      cores         = local.vm_web_resources.core
      memory        = local.vm_web_resources.mem
      core_fraction = local.vm_web_resources.core_frac
    }
    boot_disk {
      initialize_params {
        image_id = data.yandex_compute_image.image.image_id
      }
    }
    scheduling_policy {
      preemptible = true
    }
    network_interface {
      subnet_id = yandex_vpc_subnet.develop.id
      nat       = true
    }

    metadata = {
      serial-port-enable = local.ser_port
      ssh-keys           =  local.ssh_key

    }
  }
resource "yandex_compute_instance" "db" {
    name        = local.name_suffix_db
    platform_id = var.platform_db
    resources {
      cores = local.vm_db_resources.core
      memory = local.vm_db_resources.mem
      core_fraction = local.vm_db_resources.core_frac
    }
    boot_disk {
      initialize_params {
        image_id = data.yandex_compute_image.image.image_id
      }
    }
    scheduling_policy {
      preemptible = true
    }
    network_interface {
      subnet_id = yandex_vpc_subnet.develop.id
      nat       = true
    }

    metadata = {
      serial-port-enable = local.ser_port
      ssh-keys           = local.ssh_key
    }

  }
