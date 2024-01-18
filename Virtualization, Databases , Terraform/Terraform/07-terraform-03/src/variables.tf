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

variable "image_family" {
  type        = string
  description = "name image in yc"
  default = "ubuntu-2004-lts"
}

variable "name_pref" {
  type        = string
  default = "netology-develop"
}

variable "standart" {
  type        = string
  default = "standard-v1"
}

variable "resources" {
    type = list (object({
        vm_name         = string
        cpu             = number
        ram             = number
        disk            = number
        core_frac       = number
    }))
  default = [{ vm_name="main", cpu="2", ram="1", disk="1", core_frac = "5"},
  { vm_name="replica", cpu="2", ram="1", disk="2", core_frac = "20"}]
}


locals {
  type = string
  ssh_key = file("~/.ssh/id_ed25519.pub")
}

