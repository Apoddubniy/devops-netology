###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}


###ssh vars

variable "vms_ssh_root_key" {
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILiUtF85NVCt/boCAYmIFlh49IRXeiv5TWlY7dY2fO8Z lex@chrm-it-08"
  description = "ssh-keygen -t ed25519"
}

variable "vm_web_image_family" {
  description = "name image in yc"
  default = "ubuntu-2004-lts"
}

variable "vm_web_platform" {
  default = "standard-v1"
}

variable "vm_web_name" {
  default = "netology-develop-platform-web"
}

variable "instance_web" {
  description = "shortname"
  default = "web"
}

variable "instance_db" {
  description = "shortname"
  default = "db"
}

variable "prod_name_suff" {
  default = "netology-develop-platform"
}
