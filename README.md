# tf-aws-module_primitive-appmesh_virtual_gateway

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![License: CC BY-NC-ND 4.0](https://img.shields.io/badge/License-CC_BY--NC--ND_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-nd/4.0/)

## Overview

This terraform module creates a Virtual Gateway in a Service Mesh provided as input.
## Usage
A sample variable file `example.tfvars` is available in the root directory which can be used to test this module. User needs to follow the below steps to execute this module
1. Update the `example.tfvars` to manually enter values for all fields marked within `<>` to make the variable file usable
2. Create a file `provider.tf` with the below contents
   ```
    provider "aws" {
      profile = "<profile_name>"
      region  = "<region_name>"
    }
    ```
   If using `SSO`, make sure you are logged in `aws sso login --profile <profile_name>`
3. Make sure terraform binary is installed on your local. Use command `type terraform` to find the installation location. If you are using `asdf`, you can run `asfd install` and it will install the correct terraform version for you. `.tool-version` contains all the dependencies.
4. Run the `terraform` to provision infrastructure on AWS
    ```
    # Initialize
    terraform init
    # Plan
    terraform plan -var-file example.tfvars
    # Apply (this is create the actual infrastructure)
    terraform apply -var-file example.tfvars -auto-approve
   ```
## Known Issues
1. NA
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

2. The first target you care about is `env`. This is the common interface for setting up environment variables. The values of the environment variables will be used to authenticate with cloud provider from local development workstation.

`make configure` command will bring down `aws_env.sh` file on local workstation. Developer would need to modify this file, replace the environment variable values with relevant values.

These environment variables are used by `terratest` integration suit.

Then run this make target to set the environment variables on developer workstation.

```
make env
```

3. The first target you care about is `check`.

**Pre-requisites**
Before running this target it is important to ensure that, developer has created files mentioned below on local workstation under root directory of git repository that contains code for primitives/segments. Note that these files are `aws` specific. If primitive/segment under development uses any other cloud provider than AWS, this section may not be relevant.

- A file named `provider.tf` with contents below

```
provider "aws" {
  profile = "<profile_name>"
  region  = "<region_name>"
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

# Know Issues
Currently, the `encrypt at transit` is not supported in terraform. There is an open issue for this logged with Hashicorp - https://github.com/hashicorp/terraform-provider-aws/pull/26987

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.73.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_appmesh_virtual_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appmesh_virtual_gateway) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acm_certificate_arn"></a> [acm\_certificate\_arn](#input\_acm\_certificate\_arn) | ARN for the private certificate issued for the Virtual Gateway. | `string` | `null` | no |
| <a name="input_access_log_path"></a> [access\_log\_path](#input\_access\_log\_path) | The file path to write access logs to. | `string` | `"/dev/stdout"` | no |
| <a name="input_backend_file_certificate_chain"></a> [backend\_file\_certificate\_chain](#input\_backend\_file\_certificate\_chain) | The certificate chain for the certificate. | `string` | `null` | no |
| <a name="input_backend_file_private_key"></a> [backend\_file\_private\_key](#input\_backend\_file\_private\_key) | The private key for a certificate stored on the file system of the virtual node that the proxy is running on. | `string` | `null` | no |
| <a name="input_backend_sds_secret_name"></a> [backend\_sds\_secret\_name](#input\_backend\_sds\_secret\_name) | The name of the secret for the certificate. | `string` | `null` | no |
| <a name="input_backend_subject_alternative_names_exact"></a> [backend\_subject\_alternative\_names\_exact](#input\_backend\_subject\_alternative\_names\_exact) | The exact names to match. | `list(string)` | `[]` | no |
| <a name="input_file_certificate_chain"></a> [file\_certificate\_chain](#input\_file\_certificate\_chain) | The certificate chain for the certificate. | `string` | `null` | no |
| <a name="input_file_private_key"></a> [file\_private\_key](#input\_file\_private\_key) | The private key for a certificate stored on the file system of the virtual node that the proxy is running on. | `string` | `null` | no |
| <a name="input_grpc_max_requests"></a> [grpc\_max\_requests](#input\_grpc\_max\_requests) | Maximum number of inflight requests Envoy can concurrently support across all backends. | `number` | `null` | no |
| <a name="input_health_check_path"></a> [health\_check\_path](#input\_health\_check\_path) | The destination path for the health check request. | `string` | `"/"` | no |
| <a name="input_health_check_port"></a> [health\_check\_port](#input\_health\_check\_port) | The destination port for the health check request. | `number` | `8080` | no |
| <a name="input_health_check_protocol"></a> [health\_check\_protocol](#input\_health\_check\_protocol) | The protocol for the health check request. Must be one of [http http2 grpc]. | `string` | `"http"` | no |
| <a name="input_healthy_threshold"></a> [healthy\_threshold](#input\_healthy\_threshold) | The number of consecutive successful health checks required before considering an unhealthy target healthy. | `number` | `5` | no |
| <a name="input_http_max_connections"></a> [http\_max\_connections](#input\_http\_max\_connections) | Maximum number of outbound TCP connections Envoy can establish concurrently with all hosts in upstream cluster. | `number` | `null` | no |
| <a name="input_http_max_pending_requests"></a> [http\_max\_pending\_requests](#input\_http\_max\_pending\_requests) | Maximum number of inflight requests Envoy can concurrently support across all backends. | `number` | `null` | no |
| <a name="input_http2_max_requests"></a> [http2\_max\_requests](#input\_http2\_max\_requests) | Maximum number of inflight requests Envoy can concurrently support across all backends. | `number` | `null` | no |
| <a name="input_interval_millis"></a> [interval\_millis](#input\_interval\_millis) | The time period in milliseconds between each health check execution. | `number` | `30000` | no |
| <a name="input_json_key"></a> [json\_key](#input\_json\_key) | The JSON key. | `string` | `null` | no |
| <a name="input_json_value"></a> [json\_value](#input\_json\_value) | The JSON value. | `string` | `null` | no |
| <a name="input_listener_port"></a> [listener\_port](#input\_listener\_port) | The port mapping information for the listener. | `number` | `8080` | no |
| <a name="input_listener_protocol"></a> [listener\_protocol](#input\_listener\_protocol) | The protocol for the port mapping. Must be one of [http http2 grpc]. | `string` | `"http"` | no |
| <a name="input_mesh_name"></a> [mesh\_name](#input\_mesh\_name) | The name of the service mesh to create the virtual gateway in. Must be between 1 and 255 characters in length. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name to use for the virtual gateway. | `string` | n/a | yes |
| <a name="input_sds_secret_name"></a> [sds\_secret\_name](#input\_sds\_secret\_name) | The name of the secret for the certificate. | `string` | `null` | no |
| <a name="input_subject_alternative_names_exact"></a> [subject\_alternative\_names\_exact](#input\_subject\_alternative\_names\_exact) | The exact SAN to match in the request header | `list(string)` | `[]` | no |
| <a name="input_text_format"></a> [text\_format](#input\_text\_format) | The text format. | `string` | `null` | no |
| <a name="input_timeout_millis"></a> [timeout\_millis](#input\_timeout\_millis) | The amount of time to wait when receiving a response from the health check in milliseconds. | `number` | `5000` | no |
| <a name="input_tls_enforce"></a> [tls\_enforce](#input\_tls\_enforce) | Whether the policy is enforced. The default is True, if a value isn’t specified. | `bool` | `true` | no |
| <a name="input_client_tls_enforce"></a> [client\_tls\_enforce](#input\_client\_tls\_enforce) | Whether the mTLS client policy is enforced. The default is false | `bool` | `false` | no |
| <a name="input_tls_mode"></a> [tls\_mode](#input\_tls\_mode) | The mode for the listener’s Transport Layer Security (TLS) configuration. Must be one of DISABLED, PERMISSIVE, STRICT. | `string` | `"DISABLED"` | no |
| <a name="input_tls_ports"></a> [tls\_ports](#input\_tls\_ports) | If you specify a listener port other than 443, you must specify this field. | `list(number)` | `[]` | no |
| <a name="input_trust_acm_certificate_authority_arns"></a> [trust\_acm\_certificate\_authority\_arns](#input\_trust\_acm\_certificate\_authority\_arns) | One or more Amazon Resource Names (ARNs). | `list(string)` | `[]` | no |
| <a name="input_trust_backend_file_certificate_chain"></a> [trust\_backend\_file\_certificate\_chain](#input\_trust\_backend\_file\_certificate\_chain) | The certificate chain for the certificate. | `string` | `null` | no |
| <a name="input_trust_backend_sds_secret_name"></a> [trust\_backend\_sds\_secret\_name](#input\_trust\_backend\_sds\_secret\_name) | The name of the secret for the certificate. | `string` | `null` | no |
| <a name="input_trust_file_certificate_chain"></a> [trust\_file\_certificate\_chain](#input\_trust\_file\_certificate\_chain) | The certificate chain for the certificate. | `string` | `"default"` | no |
| <a name="input_trust_sds_secret_name"></a> [trust\_sds\_secret\_name](#input\_trust\_sds\_secret\_name) | The name of the secret for the certificate. | `string` | `null` | no |
| <a name="input_unhealthy_threshold"></a> [unhealthy\_threshold](#input\_unhealthy\_threshold) | The number of consecutive failed health checks that must occur before considering a target unhealthy. | `number` | `2` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | An arbitrary map of tags that can be added to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | ID of the virtual gateway |
| <a name="output_arn"></a> [arn](#output\_arn) | ARN of the virtual gateway |
| <a name="output_name"></a> [name](#output\_name) | Name of the virtual gateway |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
