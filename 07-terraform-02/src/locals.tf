locals {
  name_suffix_web = "${var.prod_name_suff}-${var.instance_web}"
  name_suffix_db = "${var.prod_name_suff}-${var.instance_db}"
  vm_web_resources = {core = "2", mem = "1", core_frac = "5"}
  vm_db_resources = {core = "2", mem = "2", core_frac = "20"}
  ser_port = "1"
  ssh_key = "ubuntu:${var.vms_ssh_root_key}"


}