variable "base_name" {
  type        = string
  description = "App name to be created"
  default     = "ubuntu-palworld"
}

variable "resource_group_location" {
  type        = string
  description = "Location for all resources."
  default     = "japaneast"
}

variable "username" {
  type        = string
  description = "The username for the local account that will be created on the new VM."
  default     = "azureadmin"
}

variable "vm_machine_type" {
  type        = string
  description = "virtual machie type"
  default     = "Standard_B4as_v2"
  # 検証用のVM
  # default = "Standard_B1ms"
}

variable "disk_size" {
  type        = number
  description = "os disk size"
  default     = 64
}

variable "own_public_ip" {
  type        = string
  description = "own public ip"
  # ssh接続用に自分のIPをterraform/secret.tfvarsで上書き
  default = ""
}

variable "vm_tag_name" {
  type    = string
  default = "vm_palworld"
}