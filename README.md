# tf-azurerm-module_primitive-windows_virtual_machine

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![License: CC BY-NC-ND 4.0](https://img.shields.io/badge/License-CC_BY--NC--ND_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-nd/4.0/)

## Overview

This terraform module creates a Windows virtual machine in Azure.

## Usage

See [examples/complete](examples/complete) for a full working example.

## Module Development

### Pre-Requisites

The following commands should be available on your system:

- `asdf` or `mise`
- `make`
- `python3` (for pre-commit)

Additionally, your `git` user and email must be configured. Run the `make configure` command from the root of the repository to ensure that you meet these requirements.

### Pre-Commit hooks

The [.pre-commit-config.yaml](.pre-commit-config.yaml) file defines `pre-commit` hooks for Terraform formatting, validation, documentation generation, and detect-secrets. Hooks are installed when you run `make configure`. Go linting runs via `make lint` in local development and CI, not via pre-commit.

### Terratest examples

Post-deploy tests in `tests/post_deploy_functional/` and `tests/post_deploy_functional_readonly/` target `examples/complete` via an explicit folder constant in each `main_test.go`. Adding another example (for example `examples/minimal`) requires a new test entry point or updating that constant; it is not picked up automatically.

### Local Validation

You should validate the changes you make to any module locally, prior to pushing your changes in a branch to GitHub.

1. Ensure that you have run `make configure` successfully.
2. Ensure you are signed into the appropriate cloud provider (e.g. Azure) for the module under test in your current console session.
3. Run the Terraform and Golang linters:

```
make lint
```

4. Once linters pass, run integration tests (apply, test, destroy):

```
make test
```

The pre-commit validations, as well as the `make lint` and `make test` targets, are performed in CI. Running them locally before opening a PR helps ensure a smooth review.

### Review & Merge Process

Open a Pull Request to the default (`main`) branch. The PR title must follow [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/#specification) format to merge and to drive semantic versioning.

Ensure CI workflows pass, address review feedback, and obtain approvals required by `CODEOWNERS`.

### Automatic Updates

Shared configuration and workflow files are largely managed through [launch-terraform-skeleton](https://github.com/launchbynttdata/launch-terraform-skeleton). Avoid one-off edits to copied skeleton files in this repository unless necessary (for example `.gitignore` entries for generated artifacts). Use `copier check-update` / `copier update` when refreshing from the skeleton.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0, < 2.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.77 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_windows_virtual_machine.public_vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | (Required) The password of the local administrator used for the Virtual Machine. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | (Required) The username of the local administrator used for the Virtual Machine. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | (Required) The Azure location where the Windows Virtual Machine should exist. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the Windows Virtual Machine. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_network_interface_ids"></a> [network\_interface\_ids](#input\_network\_interface\_ids) | (Required). A list of Network Interface IDs which should be attached to this Virtual Machine. The first Network Interface ID in this list will be the Primary Network Interface on the Virtual Machine. | `list(string)` | n/a | yes |
| <a name="input_os_disk"></a> [os\_disk](#input\_os\_disk) | An os\_disk block. | <pre>object({<br/>    caching              = string<br/>    storage_account_type = string<br/>    diff_disk_settings = optional(object({<br/>      option    = string<br/>      placement = optional(string, "CacheDisk")<br/>    }))<br/>    disk_encryption_set_id           = optional(string)<br/>    disk_size_gb                     = optional(number)<br/>    name                             = optional(string)<br/>    secure_vm_disk_encryption_set_id = optional(string)<br/>    security_encryption_type         = optional(string)<br/>    write_accelerator_enabled        = optional(bool, false)<br/>  })</pre> | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group in which the Windows Virtual Machine should be exist. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_size"></a> [size](#input\_size) | (Required) The SKU which should be used for this Virtual Machine, such as Standard\_F2. | `string` | n/a | yes |
| <a name="input_source_image_reference"></a> [source\_image\_reference](#input\_source\_image\_reference) | A source\_image\_reference block. | <pre>object({<br/>    publisher = string<br/>    offer     = string<br/>    sku       = string<br/>    version   = string<br/>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Windows Virtual Machine. |
| <a name="output_private_ip_address"></a> [private\_ip\_address](#output\_private\_ip\_address) | The Primary Private IP Address assigned to this Virtual Machine |
| <a name="output_private_ip_addresses"></a> [private\_ip\_addresses](#output\_private\_ip\_addresses) | A list of Private IP Addresses assigned to this Virtual Machine. |
| <a name="output_public_ip_address"></a> [public\_ip\_address](#output\_public\_ip\_address) | The Primary Public IP Address assigned to this Virtual Machine. |
| <a name="output_public_ip_addresses"></a> [public\_ip\_addresses](#output\_public\_ip\_addresses) | A list of Public IP Addresses assigned to this Virtual Machine. |
| <a name="output_virtual_machine_id"></a> [virtual\_machine\_id](#output\_virtual\_machine\_id) | The ID of the Virtual Machine. |
<!-- END_TF_DOCS -->
