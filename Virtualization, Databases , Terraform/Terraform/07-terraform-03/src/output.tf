output "outputs" {
  value = [
 {"name" = yandex_compute_instance.web.*.name
  "id"   = yandex_compute_instance.web.*.id
  "fqdn" = yandex_compute_instance.web.*.fqdn},

 {"name" = { for k, group in yandex_compute_instance.databases: k => group.name}
  "id"   = { for i, group in yandex_compute_instance.databases: i => group.id}
  "fqdn" = { for f, group in yandex_compute_instance.databases: f => group.fqdn}},

 {"name" = yandex_compute_instance.storage.*.name
  "id"   = yandex_compute_instance.storage.*.id
  "fqdn" = yandex_compute_instance.storage.*.fqdn }
]
}
