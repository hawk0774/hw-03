###cloud vars
variable "cloud_id" {
  type        = string
  default     = "*"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  default     = "*"
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
  description = "VPC network&subnet name"
}

variable "os_image_web" {
  type    = string
  default = "ubuntu-2004-lts"
}

variable "vm_web_disk" {
  type        = string
  default     = "*"
  description = "Type of the boot disk"
}

######################################################## for_each #######################################################

variable "vm_resources" {
  type = list(object({
    vm_name = string
    cpu     = number
    ram     = number
    disk    = number
    platform_id = string
  }))
  default = [
    {
      vm_name = "main"
      cpu     = 2
      ram     = 2
      disk    = 5
      platform_id = "standard-v1"
    },
    {
      vm_name = "replica"
      cpu     = 2
      ram     = 2
      disk    = 10
      platform_id = "standard-v1"
    },
  ]
}

###################################### count-vm #######################################

variable "yandex_compute_instance_web" {
  type        = list(object({
    vm_name = string
    cores = number
    memory = number
    core_fraction = number
    count_vms = number
    platform_id = string
  }))

  default = [{
      vm_name = "web"
      cores         = 2
      memory        = 1
      core_fraction = 5
      count_vms = 2
      platform_id = "standard-v1"
    }]
}

variable "boot_disk_web" {
  type        = list(object({
    size = number
    type = string
    }))
    default = [ {
    size = 5
    type = "network-hdd"
  }]
}

##################################### disk_vm.tf ##################################


variable "storage_secondary_disk" {
  type = list(object({
    for_storage = object({
      type       = string
      size       = number
      count      = number
      block_size = number
      name = string
    })
  }))

  default = [
    {
      for_storage = {
        type       = "network-hdd"
        size       = 1
        count      = 3
        block_size = 4096
        name = "disk"
      }
    }
  ]
}


variable "yandex_compute_instance_storage" {
  type = object({
    storage_resources = object({
      cores        = number
      memory       = number
      core_fraction = number
      name         = string
      zone         = string
    })
  })

  default = {
    storage_resources = {
      cores        = 2
      memory       = 2
      core_fraction = 5
      name         = "storage"
      zone         = "ru-central1-a"
    }
  }
}

variable "boot_disk_storage" {
  type = object({
    size = number
    type = string
  })
  default = {
    size = 5
    type = "network-hdd"
  }
}






