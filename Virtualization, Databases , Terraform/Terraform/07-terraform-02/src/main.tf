resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}


data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_image_family
}
resource "yandex_compute_instance" "platform" {
  name        = var.vm_web_name
  platform_id = var.vm_web_platform
  resources {
      cores         = local.vm_web_resources.core
      memory        = local.vm_web_resources.mem
      core_fraction = local.vm_web_resources.core_frac
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
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

data "yandex_compute_image" "bubuntu" {
  family = var.vm_db_image_family
}
resource "yandex_compute_instance" "db" {
  name        = var.vm_db_name
  platform_id = var.vm_db_platform
  resources {
      cores = local.vm_db_resources.core
      memory = local.vm_db_resources.mem
      core_fraction = local.vm_db_resources.core_frac
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
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

