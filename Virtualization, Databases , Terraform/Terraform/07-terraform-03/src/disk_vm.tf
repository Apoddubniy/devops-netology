
resource "yandex_compute_disk" "second_hdd" {
  name       = "disk-${count.index}"
  type       = "network-hdd"
  zone       = var.default_zone
  size       = 1
  block_size = 4096
  count = 3
}

resource "yandex_compute_instance" "storage" {
  platform_id = var.standart
  name = "${var.name_pref}-storage"
  count = 1

  boot_disk {
    initialize_params {
        image_id = data.yandex_compute_image.image.image_id
      }
  }
    dynamic secondary_disk {
      for_each    = yandex_compute_disk.second_hdd.*.id
      content {
        disk_id   = secondary_disk.value
      }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat = true
  }
  resources {
    cores  = 2
    memory = 1
    core_fraction = 5
  }
  metadata = {
    ssh = "ubuntu:${local.ssh_key}"
  }
}

