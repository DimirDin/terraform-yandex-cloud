### VM Resources map - Задание 6

variable "vms_resources" {
  type = map(object({
    cores         = number
    memory        = number
    core_fraction = number
    hdd_size      = number
    hdd_type      = string
  }))
  default = {
    web = {
      cores         = 2
      memory        = 2
      core_fraction = 5
      hdd_size      = 10
      hdd_type      = "network-hdd"
    }
    db = {
      cores         = 2
      memory        = 2
      core_fraction = 20
      hdd_size      = 10
      hdd_type      = "network-ssd"
    }
  }
}

### VM Metadata map - Задание 6

variable "vms_metadata" {
  type = object({
    serial-port-enable = number
    ssh-keys           = string
  })
  default = {
    serial-port-enable = 1
    ssh-keys           = null
  }
}

### VM Web vars

variable "vm_web_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "VM image family"
}

variable "vm_web_name" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "VM name"
}

variable "vm_web_platform_id" {
  type        = string
  default     = "standard-v1"  # ИСПРАВЛЕНО: была standard-v4
  description = "VM platform ID"
}

variable "vm_web_preemptible" {
  type        = bool
  default     = true
  description = "VM preemptible status"
}

variable "vm_web_nat" {
  type        = bool
  default     = true
  description = "VM NAT enabled"
}

### VM DB vars - Задание 3

variable "vm_db_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "VM DB image family"
}

variable "vm_db_name" {
  type        = string
  default     = "netology-develop-platform-db"
  description = "VM DB name"
}

variable "vm_db_platform_id" {
  type        = string
  default     = "standard-v1"  # ИСПРАВЛЕНО: была standard-v4
  description = "VM DB platform ID"
}

variable "vm_db_preemptible" {
  type        = bool
  default     = true
  description = "VM DB preemptible status"
}

variable "vm_db_nat" {
  type        = bool
  default     = true
  description = "VM DB NAT enabled"
}

variable "vm_db_zone" {
  type        = string
  default     = "ru-central1-b"
  description = "VM DB zone"
}

### Закомментированные переменные - Задание 6
# Заменены на vms_resources map

# variable "vm_web_cores" {
#   type        = number
#   default     = 2
# }
# 
# variable "vm_web_memory" {
#   type        = number
#   default     = 2
# }
# 
# variable "vm_web_core_fraction" {
#   type        = number
#   default     = 5
# }
# 
# variable "vm_db_cores" {
#   type        = number
#   default     = 2
# }
# 
# variable "vm_db_memory" {
#   type        = number
#   default     = 2
# }
# 
# variable "vm_db_core_fraction" {
#   type        = number
#   default     = 20
# }
