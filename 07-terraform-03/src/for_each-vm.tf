resource "yandex_compute_instance" "databases" {
  depends_on = [yandex_compute_instance.web]
  for_each = {
    for key, param in var.resources : param.vm_name => param
  }
  name = "${var.name_pref}-${each.value.vm_name}"

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
    cores = each.value.cpu
    memory = each.value.ram
    core_fraction = each.value.core_frac
  }
  metadata = {
    ssh = "ubuntu:${local.ssh_key}"
  }
}

