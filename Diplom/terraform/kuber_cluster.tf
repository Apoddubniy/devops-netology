
resource "yandex_kubernetes_cluster" "kuber-cluster" {
  name        = var.kuber_cluster_name
  network_id = yandex_vpc_network.network-main.id


  master {
    regional {
      region = var.region

     dynamic "location" {
       for_each = {for key, n in yandex_vpc_subnet.subnet-main : n.name => n}
       content {
         zone      = location.value.zone
         subnet_id = location.value.id
       }
     }
    }
    security_group_ids = [
      yandex_vpc_security_group.internal.id,
      yandex_vpc_security_group.k8s_master.id]
    version   = var.kub_version
    public_ip = true
  }

  service_account_id      = yandex_iam_service_account.sa.id
  node_service_account_id = yandex_iam_service_account.sa.id
  depends_on = [
    yandex_resourcemanager_folder_iam_binding.editor
  ]
  kms_provider {
    key_id = yandex_kms_symmetric_key.kms-key.id
  }
  provisioner "local-exec" {
      command  = "yc managed-kubernetes cluster get-credentials --id ${yandex_kubernetes_cluster.kuber-cluster.id} --external --force --kubeconfig=${var.path_to_kubconfig}"
    }
  provisioner "local-exec" {
    when    = destroy
    command = "rm -f /tmp/config"
  }
}

