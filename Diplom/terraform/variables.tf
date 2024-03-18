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

variable "network_name" {
  description = "The name of main network"
  type        = string
}

variable "subnets" {
  type = list(object(
    {
      name = string,
      zone = string,
      cidr = list(string)
    })
  )
}

variable "default_zone" {
  description = "The default zone"
  type        = string
  default     = "ru-cenral1-a"
}

variable "region" {
  type = string
  default = "ru-central1"
}

variable "kub_version" {
  type = string
  default = 1.28
}

variable "white_ips" {
  type = list(string)
}

variable "vpc_name" {
  type        = string
  default     = "kub-network"
  description = "VPC network & subnet name"
}

variable "kuber_cluster_name" {
  type = string
  default = "clusterok-devops25"
}

variable "service_account_name" {
  type = string
  default = null
}

variable "path_to_kubconfig" {
  type = string
  default = "/tmp/config"
}

variable "resources_nodes" {
  description = "Resources"
  default = {}
}