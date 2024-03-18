resource "yandex_iam_service_account" "sa" {
  name        = var.service_account_name
  description = "K8S regional service account"
}

resource "yandex_resourcemanager_folder_iam_binding" "k8s-editor" {
  folder_id = var.folder_id
  role      = "k8s.editor"
  members = [
    "serviceAccount:${yandex_iam_service_account.sa.id}"
  ]
}

resource "yandex_resourcemanager_folder_iam_binding" "k8s-api-editor" {
  folder_id = var.folder_id
  role      = "k8s.cluster-api.cluster-admin"
  members = [
    "serviceAccount:${yandex_iam_service_account.sa.id}"
  ]
}

resource "yandex_resourcemanager_folder_iam_binding" "res-manager" {
  folder_id = var.folder_id
  role      = "resource-manager.editor"
  members = [
    "serviceAccount:${yandex_iam_service_account.sa.id}"
  ]
}

resource "yandex_resourcemanager_folder_iam_binding" "vpc-admin" {
  folder_id = var.folder_id
  role      = "vpc.admin"
  members = [
    "serviceAccount:${yandex_iam_service_account.sa.id}"
  ]
}

resource "yandex_resourcemanager_folder_iam_binding" "storage" {
  folder_id = var.folder_id
  role      = "storage.editor"
  members = [
    "serviceAccount:${yandex_iam_service_account.sa.id}"
  ]
}

resource "yandex_resourcemanager_folder_iam_binding" "alb-editor" {
  folder_id = var.folder_id
  role      = "alb.editor"
  members = [
    "serviceAccount:${yandex_iam_service_account.sa.id}"
  ]
}

resource "yandex_resourcemanager_folder_iam_binding" "editor" {
  folder_id = var.folder_id
  role      = "editor"
  members = [
    "serviceAccount:${yandex_iam_service_account.sa.id}"
  ]
}


resource "yandex_resourcemanager_folder_iam_binding" "container-registry" {
  folder_id = var.folder_id
  role      = "container-registry.editor"
  members = [
    "serviceAccount:${yandex_iam_service_account.sa.id}"
  ]
}

resource "yandex_kms_symmetric_key" "kms-key" {
  name              = "kms-key"
  default_algorithm = "AES_128"
  rotation_period   = "8760h" # 1 год.
}

resource "yandex_kms_symmetric_key_iam_binding" "viewer" {
  symmetric_key_id = yandex_kms_symmetric_key.kms-key.id
  role             = "viewer"
  members = [
    "serviceAccount:${yandex_iam_service_account.sa.id}",
  ]
}