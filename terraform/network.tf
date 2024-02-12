resource "azurerm_virtual_network" "palworld_vn" {
  name                = "${var.base_name}-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_public_ip" "palworld_pid" {
  name                = "${var.base_name}-public-ip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
}

resource "azurerm_subnet" "palworld_subnet" {
  name                 = "${var.base_name}-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.palworld_vn.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_security_group" "palworld_security_group" {
  name                = "${var.base_name}-nsg"
  location            = var.resource_group_location
  resource_group_name = azurerm_resource_group.rg.name

  # リモートデスクトップは自分のIPしか通さない
  security_rule {
    name                       = "${var.base_name}-allow-ssh"
    description                = "Palworld Allow SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "${var.own_public_ip}/32"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "${var.base_name}-allow-internet-outbound"
    priority                   = 1002
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "Internet"
  }
}

resource "azurerm_route_table" "palworld_route_table" {
  name                = "${var.base_name}-route-table"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}

resource "azurerm_route" "palworld_main_route_table" {
  name                = "${var.base_name}-route"
  resource_group_name = azurerm_resource_group.rg.name
  route_table_name    = azurerm_route_table.palworld_route_table.name
  address_prefix      = "0.0.0.0/0"
  next_hop_type       = "Internet"
}

resource "azurerm_network_interface" "palworld_network_if" {
  name                = "${var.base_name}-interface"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.palworld_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.palworld_pid.id
  }
}

resource "azurerm_network_interface_security_group_association" "palworld_subnet_sg_assn" {
  network_interface_id      = azurerm_network_interface.palworld_network_if.id
  network_security_group_id = azurerm_network_security_group.palworld_security_group.id
}

