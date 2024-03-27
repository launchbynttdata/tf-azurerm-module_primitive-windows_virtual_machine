// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

variable "name" {
  type        = string
  description = " (Required) The name of the Windows Virtual Machine. Changing this forces a new resource to be created."
}

variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the Resource Group in which the Windows Virtual Machine should be exist. Changing this forces a new resource to be created."
}

variable "location" {
  type        = string
  description = "(Required) The Azure location where the Windows Virtual Machine should exist. Changing this forces a new resource to be created."
}

variable "size" {
  type        = string
  description = "(Required) The SKU which should be used for this Virtual Machine, such as Standard_F2."
}

variable "admin_username" {
  type        = string
  description = "(Required) The username of the local administrator used for the Virtual Machine. Changing this forces a new resource to be created."
}

variable "admin_password" {
  type        = string
  description = "(Required) The password of the local administrator used for the Virtual Machine. Changing this forces a new resource to be created."
}

variable "network_interface_ids" {
  type        = list(string)
  description = " (Required). A list of Network Interface IDs which should be attached to this Virtual Machine. The first Network Interface ID in this list will be the Primary Network Interface on the Virtual Machine."
}

variable "os_disk" {
  type = object({
    caching              = string
    storage_account_type = string
    diff_disk_settings = optional(object({
      option    = string
      placement = optional(string, "CacheDisk")
    }))
    disk_encryption_set_id           = optional(string)
    disk_size_gb                     = optional(number)
    name                             = optional(string)
    secure_vm_disk_encryption_set_id = optional(string)
    security_encryption_type         = optional(string)
    write_accelerator_enabled        = optional(bool, false)
  })
  description = "An os_disk block."
}

variable "source_image_reference" {
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  description = "A source_image_reference block."
}
