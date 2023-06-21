output "ip_web" {
  value ="{${yandex_compute_instance.platform.name} = ${yandex_compute_instance.platform.network_interface[0].nat_ip_address}}"
}

output "ip_db" {
 value ="{${yandex_compute_instance.db.name} = ${yandex_compute_instance.db.network_interface[0].nat_ip_address}}"
}