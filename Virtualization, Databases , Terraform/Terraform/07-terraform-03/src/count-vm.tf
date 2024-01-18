resource "yandex_compute_instance" "web" {
  count = 2
  platform_id = var.standart
  name = "${var.name_pref}-web-${count.index + 1}"
  boot_disk {
    initialize_params {
        image_id = data.yandex_compute_image.image.image_id
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