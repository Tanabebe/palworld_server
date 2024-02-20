variable "base_name" {
  type        = string
  description = "base name"
  default     = "ubuntu-palworld"
}

variable "resource_group_location" {
  type        = string
  description = "resource location"
  default     = "japaneast"
}

variable "username" {
  type        = string
  description = "username used in vm"
  default     = "azureadmin"
}

variable "vm_machine_type" {
  type        = string
  description = "virtual machie type"
  default     = "Standard_B4as_v2"
}

variable "disk_size" {
  type        = number
  description = "os disk size"
  default     = 64
}

variable "vm_tag_name" {
  type        = string
  description = "vm tag name"
  default     = "vm_palworld"
}

variable "ssh_connection_allowed_port" {
  type        = string
  description = "ssh connection allowed port"
  default     = ""
}

# terraform/secret.tfvarsで上書き
variable "allowed_server_access_ip_list" {
  type        = list(string)
  description = "ip address that can access Palworld server"
  default     = ["*"]
}

variable "ssh_connection_allowed_ip_list" {
  type        = list(string)
  description = "ssh connection allowed ip"
  default     = ["*"]
}