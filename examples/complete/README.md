# complete

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0, <= 1.5.5 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.77 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.6 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_random"></a> [random](#provider\_random) | 3.6.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_virtual_machine"></a> [virtual\_machine](#module\_virtual\_machine) | d2lqlh14iel5k2.cloudfront.net/module_primitive/windows_virtual_machine/azurerm | ~> 1.0 |
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | d2lqlh14iel5k2.cloudfront.net/module_primitive/resource_group/azurerm | ~> 1.0 |
| <a name="module_network_interface"></a> [network\_interface](#module\_network\_interface) | d2lqlh14iel5k2.cloudfront.net/module_primitive/network_interface/azurerm | ~> 1.0 |
| <a name="module_virtual_network"></a> [virtual\_network](#module\_virtual\_network) | d2lqlh14iel5k2.cloudfront.net/module_collection/virtual_network/azurerm | ~> 1.0 |
| <a name="module_resource_names"></a> [resource\_names](#module\_resource\_names) | d2lqlh14iel5k2.cloudfront.net/module_library/resource_name/launch | ~> 1.0 |

## Resources

| Name | Type |
|------|------|
| [random_string.admin_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_resource_names_map"></a> [resource\_names\_map](#input\_resource\_names\_map) | A map of key to resource\_name that will be used by tf-launch-module\_library-resource\_name to generate resource names | <pre>map(object({<br>    name       = string<br>    max_length = optional(number, 60)<br>  }))</pre> | <pre>{<br>  "network_interface": {<br>    "max_length": 80,<br>    "name": "iface"<br>  },<br>  "resource_group": {<br>    "max_length": 80,<br>    "name": "rg"<br>  },<br>  "virtual_machine": {<br>    "max_length": 15,<br>    "name": "vm"<br>  },<br>  "virtual_network_vnet": {<br>    "max_length": 80,<br>    "name": "vnet"<br>  }<br>}</pre> | no |
| <a name="input_instance_env"></a> [instance\_env](#input\_instance\_env) | Number that represents the instance of the environment. | `number` | `0` | no |
| <a name="input_instance_resource"></a> [instance\_resource](#input\_instance\_resource) | Number that represents the instance of the resource. | `number` | `0` | no |
| <a name="input_logical_product_family"></a> [logical\_product\_family](#input\_logical\_product\_family) | (Required) Name of the product family for which the resource is created.<br>    Example: org\_name, department\_name. | `string` | `"launch"` | no |
| <a name="input_logical_product_service"></a> [logical\_product\_service](#input\_logical\_product\_service) | (Required) Name of the product service for which the resource is created.<br>    For example, backend, frontend, middleware etc. | `string` | `"virtualmachine"` | no |
| <a name="input_class_env"></a> [class\_env](#input\_class\_env) | (Required) Environment where resource is going to be deployed. For example. dev, qa, uat | `string` | `"dev"` | no |
| <a name="input_location"></a> [location](#input\_location) | target resource group resource mask | `string` | n/a | yes |
| <a name="input_size"></a> [size](#input\_size) | (Required) The SKU which should be used for this Virtual Machine, such as Standard\_F2. | `string` | n/a | yes |
| <a name="input_source_image_reference"></a> [source\_image\_reference](#input\_source\_image\_reference) | A source\_image\_reference block. | <pre>object({<br>    publisher = string<br>    offer     = string<br>    sku       = string<br>    version   = string<br>  })</pre> | n/a | yes |
| <a name="input_os_disk"></a> [os\_disk](#input\_os\_disk) | An os\_disk block. | <pre>object({<br>    caching              = string<br>    storage_account_type = string<br>    diff_disk_settings = optional(object({<br>      option    = string<br>      placement = optional(string, "CacheDisk")<br>    }))<br>    disk_encryption_set_id           = optional(string)<br>    disk_size_gb                     = optional(number)<br>    name                             = optional(string)<br>    secure_vm_disk_encryption_set_id = optional(string)<br>    security_encryption_type         = optional(string)<br>    write_accelerator_enabled        = optional(bool, false)<br>  })</pre> | n/a | yes |
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | Username of the administrative account on the virtual machine | `string` | n/a | yes |
| <a name="input_length"></a> [length](#input\_length) | Admin password generation | `number` | `24` | no |
| <a name="input_number"></a> [number](#input\_number) | n/a | `bool` | `true` | no |
| <a name="input_special"></a> [special](#input\_special) | n/a | `bool` | `false` | no |
| <a name="input_network_map"></a> [network\_map](#input\_network\_map) | Map of spoke networks where vnet name is key, and value is object containing attributes to create a network | <pre>map(object({<br>    resource_group_name = optional(string)<br>    location            = optional(string)<br>    vnet_name           = optional(string)<br>    address_space       = list(string)<br>    subnet_names        = list(string)<br>    subnet_prefixes     = list(string)<br>    bgp_community       = string<br>    ddos_protection_plan = object(<br>      {<br>        enable = bool<br>        id     = string<br>      }<br>    )<br>    dns_servers                                           = list(string)<br>    nsg_ids                                               = map(string)<br>    route_tables_ids                                      = map(string)<br>    subnet_delegation                                     = map(map(any))<br>    subnet_enforce_private_link_endpoint_network_policies = map(bool)<br>    subnet_enforce_private_link_service_network_policies  = map(bool)<br>    subnet_service_endpoints                              = map(list(string))<br>    tags                                                  = map(string)<br>    tracing_tags_enabled                                  = bool<br>    tracing_tags_prefix                                   = string<br>    use_for_each                                          = bool<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | ID of the Virtual Machine |
| <a name="output_name"></a> [name](#output\_name) | Name of the Virtual Machine |
| <a name="output_private_ip_addresses"></a> [private\_ip\_addresses](#output\_private\_ip\_addresses) | Private IP Addresses |
| <a name="output_public_ip_addresses"></a> [public\_ip\_addresses](#output\_public\_ip\_addresses) | Public IP Addresses |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | Name of the resource group |
| <a name="output_admin_username"></a> [admin\_username](#output\_admin\_username) | Login of the administrative user |
| <a name="output_admin_password"></a> [admin\_password](#output\_admin\_password) | Password of the administrative user |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
