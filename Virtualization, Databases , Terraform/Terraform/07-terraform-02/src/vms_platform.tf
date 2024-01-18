variable "vm_db_image_family" {
  description = "name image in yc"
  default = "ubuntu-2004-lts"
}

variable "vm_db_platform" {
  default = "standard-v1"
}

variable "vm_db_name" {
  default = "netology-develop-platform-db"
}