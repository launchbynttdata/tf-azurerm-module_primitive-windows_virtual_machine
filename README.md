# tf-azurerm-module_primitive-windows_virtual_machine

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![License: CC BY-NC-ND 4.0](https://img.shields.io/badge/License-CC_BY--NC--ND_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-nd/4.0/)

## Overview

What does this module do?

## Pre-Commit hooks

[.pre-commit-config.yaml](.pre-commit-config.yaml) file defines certain `pre-commit` hooks that are relevant to terraform, golang and common linting tasks. There are no custom hooks added.

`commitlint` hook enforces commit message in certain format. The commit contains the following structural elements, to communicate intent to the consumers of your commit messages:

- **fix**: a commit of the type `fix` patches a bug in your codebase (this correlates with PATCH in Semantic Versioning).
- **feat**: a commit of the type `feat` introduces a new feature to the codebase (this correlates with MINOR in Semantic Versioning).
- **BREAKING CHANGE**: a commit that has a footer `BREAKING CHANGE:`, or appends a `!` after the type/scope, introduces a breaking API change (correlating with MAJOR in Semantic Versioning). A BREAKING CHANGE can be part of commits of any type.
footers other than BREAKING CHANGE: <description> may be provided and follow a convention similar to git trailer format.
- **build**: a commit of the type `build` adds changes that affect the build system or external dependencies (example scopes: gulp, broccoli, npm)
- **chore**: a commit of the type `chore` adds changes that don't modify src or test files
- **ci**: a commit of the type `ci` adds changes to our CI configuration files and scripts (example scopes: Travis, Circle, BrowserStack, SauceLabs)
- **docs**: a commit of the type `docs` adds documentation only changes
- **perf**: a commit of the type `perf` adds code change that improves performance
- **refactor**: a commit of the type `refactor` adds code change that neither fixes a bug nor adds a feature
- **revert**: a commit of the type `revert` reverts a previous commit
- **style**: a commit of the type `style` adds code changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
- **test**: a commit of the type `test` adds missing tests or correcting existing tests

Base configuration used for this project is [commitlint-config-conventional (based on the Angular convention)](https://github.com/conventional-changelog/commitlint/tree/master/@commitlint/config-conventional#type-enum)

If you are a developer using vscode, [this](https://marketplace.visualstudio.com/items?itemName=joshbolduc.commitlint) plugin may be helpful.

`detect-secrets-hook` prevents new secrets from being introduced into the baseline. TODO: INSERT DOC LINK ABOUT HOOKS

In order for `pre-commit` hooks to work properly

- You need to have the pre-commit package manager installed. [Here](https://pre-commit.com/#install) are the installation instructions.
- `pre-commit` would install all the hooks when commit message is added by default except for `commitlint` hook. `commitlint` hook would need to be installed manually using the command below

```
pre-commit install --hook-type commit-msg
```

## To test the resource group module locally

1. For development/enhancements to this module locally, you'll need to install all of its components. This is controlled by the `configure` target in the project's [`Makefile`](./Makefile). Before you can run `configure`, familiarize yourself with the variables in the `Makefile` and ensure they're pointing to the right places.

```
make configure
```

This adds in several files and directories that are ignored by `git`. They expose many new Make targets.

2. _THIS STEP APPLIES ONLY TO MICROSOFT AZURE. IF YOU ARE USING A DIFFERENT PLATFORM PLEASE SKIP THIS STEP._ The first target you care about is `env`. This is the common interface for setting up environment variables. The values of the environment variables will be used to authenticate with cloud provider from local development workstation.

`make configure` command will bring down `azure_env.sh` file on local workstation. Devloper would need to modify this file, replace the environment variable values with relevant values.

These environment variables are used by `terratest` integration suit.

Service principle used for authentication(value of ARM_CLIENT_ID) should have below privileges on resource group within the subscription.

```
"Microsoft.Resources/subscriptions/resourceGroups/write"
"Microsoft.Resources/subscriptions/resourceGroups/read"
"Microsoft.Resources/subscriptions/resourceGroups/delete"
```

Then run this make target to set the environment variables on developer workstation.

```
make env
```

3. The first target you care about is `check`.

**Pre-requisites**
Before running this target it is important to ensure that, developer has created files mentioned below on local workstation under root directory of git repository that contains code for primitives/segments. Note that these files are `azure` specific. If primitive/segment under development uses any other cloud provider than azure, this section may not be relevant.

- A file named `provider.tf` with contents below

```
provider "azurerm" {
  features {}
}
```

- A file named `terraform.tfvars` which contains key value pair of variables used.

Note that since these files are added in `gitignore` they would not be checked in into primitive/segment's git repo.

After creating these files, for running tests associated with the primitive/segment, run

```
make check
```

If `make check` target is successful, developer is good to commit the code to primitive/segment's git repo.

`make check` target

- runs `terraform commands` to `lint`,`validate` and `plan` terraform code.
- runs `conftests`. `conftests` make sure `policy` checks are successful.
- runs `terratest`. This is integration test suit.
- runs `opa` tests
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | <= 1.5.5 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | =3.77.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.77.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_windows_virtual_machine.public_vm](https://registry.terraform.io/providers/hashicorp/azurerm/3.77.0/docs/resources/windows_virtual_machine) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the Windows Virtual Machine. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group in which the Windows Virtual Machine should be exist. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | (Required) The Azure location where the Windows Virtual Machine should exist. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_size"></a> [size](#input\_size) | (Required) The SKU which should be used for this Virtual Machine, such as Standard\_F2. | `string` | n/a | yes |
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | (Required) The username of the local administrator used for the Virtual Machine. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | (Required) The password of the local administrator used for the Virtual Machine. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_network_interface_ids"></a> [network\_interface\_ids](#input\_network\_interface\_ids) | (Required). A list of Network Interface IDs which should be attached to this Virtual Machine. The first Network Interface ID in this list will be the Primary Network Interface on the Virtual Machine. | `list(string)` | n/a | yes |
| <a name="input_os_disk"></a> [os\_disk](#input\_os\_disk) | An os\_disk block. | <pre>object({<br>    caching              = string<br>    storage_account_type = string<br>    diff_disk_settings = optional(object({<br>      option    = string<br>      placement = optional(string, "CacheDisk")<br>    }))<br>    disk_encryption_set_id           = optional(string)<br>    disk_size_gb                     = optional(number)<br>    name                             = optional(string)<br>    secure_vm_disk_encryption_set_id = optional(string)<br>    security_encryption_type         = optional(string)<br>    write_accelerator_enabled        = optional(bool, false)<br>  })</pre> | n/a | yes |
| <a name="input_source_image_reference"></a> [source\_image\_reference](#input\_source\_image\_reference) | A source\_image\_reference block. | <pre>object({<br>    publisher = string<br>    offer     = string<br>    sku       = string<br>    version   = string<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Windows Virtual Machine. |
| <a name="output_private_ip_address"></a> [private\_ip\_address](#output\_private\_ip\_address) | The Primary Private IP Address assigned to this Virtual Machine |
| <a name="output_private_ip_addresses"></a> [private\_ip\_addresses](#output\_private\_ip\_addresses) | A list of Private IP Addresses assigned to this Virtual Machine. |
| <a name="output_public_ip_address"></a> [public\_ip\_address](#output\_public\_ip\_address) | The Primary Public IP Address assigned to this Virtual Machine. |
| <a name="output_public_ip_addresses"></a> [public\_ip\_addresses](#output\_public\_ip\_addresses) | A list of Public IP Addresses assigned to this Virtual Machine. |
| <a name="output_virtual_machine_id"></a> [virtual\_machine\_id](#output\_virtual\_machine\_id) | The ID of the Virtual Machine. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
