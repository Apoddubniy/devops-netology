resource "yandex_compute_instance" "public_nat_instance" {
#  count = 1
  platform_id = var.standart
  name = "${var.name_pref}-public-1"
  boot_disk {
    initialize_params {
        image_id = var.image_id_nat
      }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.public.id
    ip_address = "192.168.10.254"
    nat = true
    security_group_ids = [yandex_vpc_security_group.nat-instance-sg.id]
  }

   scheduling_policy {
    preemptible = true
  }
  resources {
    cores  = 2
    memory = 1
    core_fraction = 20
  }
  metadata = {
    user-data = "#cloud-config\nusers:\n  - name: ${var.vm_user}\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh-authorized-keys:\n      - ${file("${var.ssh_key_path}")}"
  }
}

resource "yandex_compute_instance" "private" {
  platform_id = var.standart
  name = "${var.name_pref}-private-1"
  boot_disk {
    initialize_params {
        image_id = var.vm_image_id

      }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.private.id
    security_group_ids = [yandex_vpc_security_group.nat-instance-sg.id]
  }
   scheduling_policy {
    preemptible = true
  }
  resources {
    cores  = 2
    memory = 1
    core_fraction = 20
  }
  metadata = {
    user-data = "#cloud-config\nusers:\n  - name: ${var.vm_user}\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh-authorized-keys:\n      - ${file("${var.ssh_key_path}")}"
  }
}