resource "local_file" "hosts_conf" {
  content = templatefile("${path.module}/ansible.tftpl",
    { web = yandex_compute_instance.web ,
      databases = yandex_compute_instance.databases,
      storage = yandex_compute_instance.storage  })

  filename = "${abspath(path.module)}/hosts"

}

resource "null_resource" "web_hosts_provision" {
  #Ждем создания инстанса
  depends_on = [yandex_compute_instance.web, yandex_compute_instance.storage, yandex_compute_instance.databases]

  provisioner "local-exec" {
    command = "cat ~/.ssh/id_ed25519 | ssh-add -"
  }
 provisioner "local-exec" {
    command = "sleep 30"
  }

  provisioner "local-exec" {
    command     = " ansible-playbook  ${abspath(path.module)}/test.yml"
    on_failure  = continue #Продолжить выполнение terraform pipeline в случае ошибок
#    environment = { ANSIBLE_HOST_KEY_CHECKING = "False" }

    #срабатывание триггера при изменении переменных
  }
  triggers = {
    always_run        = "${timestamp()}" #всегда т.к. дата и время постоянно изменяются
    playbook_src_hash = file("${abspath(path.module)}/test.yml") # при изменении содержимого playbook файла
    ssh_public_key    = local.ssh_key # при изменении переменной
  }
}

