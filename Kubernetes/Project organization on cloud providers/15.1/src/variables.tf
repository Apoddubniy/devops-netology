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
  default     = "ru-central1-b"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr_public" {
  type        = list(string)
  default     = ["192.168.10.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "default_cidr_private" {
  type        = list(string)
  default     = ["192.168.20.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vm_image_id" {
  description = "id image in yc"
  default = "fd8vljd295nqdaoogf3g"
}

variable "vpc_name" {
  type        = string
  default     = "netology"
  description = "VPC network & subnet name"
}

variable "vpc_name_public" {
  type        = string
  default     = "netology-public"
  description = "VPC network & subnet name"
}

variable "vpc_name_private" {
  type        = string
  default     = "netology-private"
  description = "VPC network & subnet name"
}

variable "image_id_nat" {
  description = "id image in yc"
  default = "fd80mrhj8fl2oe87o4e1"
}

variable "name_pref" {
  default = "netology"
}

variable "standart" {
  default = "standard-v1"
}

variable "vm_user" {
  type = string
  default = "ubuntu"
}

variable "ssh_key_path" {
  type = string
  default = "~/.ssh/id_ed25519.pub"
}


