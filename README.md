# tf-aws-module_primitive-appmesh_virtual_gateway

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![License: CC BY-NC-ND 4.0](https://img.shields.io/badge/License-CC_BY--NC--ND_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-nd/4.0/)

## Overview

This terraform module creates a Virtual Gateway in a Service Mesh provided as input.

## Known Issues

Currently, the `encrypt at transit` is not supported in terraform. There is an open issue for this logged with Hashicorp - https://github.com/hashicorp/terraform-provider-aws/pull/26987

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_appmesh_virtual_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appmesh_virtual_gateway) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_log_path"></a> [access\_log\_path](#input\_access\_log\_path) | The file path to write access logs to. | `string` | `"/dev/stdout"` | no |
| <a name="input_acm_certificate_arn"></a> [acm\_certificate\_arn](#input\_acm\_certificate\_arn) | ARN for the private certificate issued for the Virtual Gateway. | `string` | `null` | no |
| <a name="input_backend_file_certificate_chain"></a> [backend\_file\_certificate\_chain](#input\_backend\_file\_certificate\_chain) | The certificate chain for the certificate. | `string` | `null` | no |
| <a name="input_backend_file_private_key"></a> [backend\_file\_private\_key](#input\_backend\_file\_private\_key) | The private key for a certificate stored on the file system of the virtual node that the proxy is running on. | `string` | `null` | no |
| <a name="input_backend_sds_secret_name"></a> [backend\_sds\_secret\_name](#input\_backend\_sds\_secret\_name) | The name of the secret for the certificate. | `string` | `null` | no |
| <a name="input_backend_subject_alternative_names_exact"></a> [backend\_subject\_alternative\_names\_exact](#input\_backend\_subject\_alternative\_names\_exact) | The exact names to match. | `list(string)` | `[]` | no |
| <a name="input_client_tls_enforce"></a> [client\_tls\_enforce](#input\_client\_tls\_enforce) | Whether the mTLS client policy is enforced. The default is false | `bool` | `false` | no |
| <a name="input_file_certificate_chain"></a> [file\_certificate\_chain](#input\_file\_certificate\_chain) | The certificate chain for the certificate. | `string` | `null` | no |
| <a name="input_file_private_key"></a> [file\_private\_key](#input\_file\_private\_key) | The private key for a certificate stored on the file system of the virtual node that the proxy is running on. | `string` | `null` | no |
| <a name="input_grpc_max_requests"></a> [grpc\_max\_requests](#input\_grpc\_max\_requests) | Maximum number of inflight requests Envoy can concurrently support across all backends. | `number` | `null` | no |
| <a name="input_health_check_path"></a> [health\_check\_path](#input\_health\_check\_path) | The destination path for the health check request. | `string` | `"/"` | no |
| <a name="input_health_check_port"></a> [health\_check\_port](#input\_health\_check\_port) | The destination port for the health check request. | `number` | `8080` | no |
| <a name="input_health_check_protocol"></a> [health\_check\_protocol](#input\_health\_check\_protocol) | The protocol for the health check request. Must be one of [http http2 grpc]. | `string` | `"http"` | no |
| <a name="input_healthy_threshold"></a> [healthy\_threshold](#input\_healthy\_threshold) | The number of consecutive successful health checks required before considering an unhealthy target healthy. | `number` | `5` | no |
| <a name="input_http2_max_requests"></a> [http2\_max\_requests](#input\_http2\_max\_requests) | Maximum number of inflight requests Envoy can concurrently support across all backends. | `number` | `null` | no |
| <a name="input_http_max_connections"></a> [http\_max\_connections](#input\_http\_max\_connections) | Maximum number of outbound TCP connections Envoy can establish concurrently with all hosts in upstream cluster. | `number` | `null` | no |
| <a name="input_http_max_pending_requests"></a> [http\_max\_pending\_requests](#input\_http\_max\_pending\_requests) | Maximum number of inflight requests Envoy can concurrently support across all backends. | `number` | `null` | no |
| <a name="input_interval_millis"></a> [interval\_millis](#input\_interval\_millis) | The time period in milliseconds between each health check execution. | `number` | `30000` | no |
| <a name="input_json_key"></a> [json\_key](#input\_json\_key) | The JSON key. | `string` | `null` | no |
| <a name="input_json_value"></a> [json\_value](#input\_json\_value) | The JSON value. | `string` | `null` | no |
| <a name="input_listener_port"></a> [listener\_port](#input\_listener\_port) | The port mapping information for the listener. | `number` | `8080` | no |
| <a name="input_listener_protocol"></a> [listener\_protocol](#input\_listener\_protocol) | The protocol for the port mapping. Must be one of [http http2 grpc]. | `string` | `"http"` | no |
| <a name="input_mesh_name"></a> [mesh\_name](#input\_mesh\_name) | The name of the service mesh to create the virtual gateway in. Must be between 1 and 255 characters in length. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name to use for the virtual gateway. | `string` | n/a | yes |
| <a name="input_sds_secret_name"></a> [sds\_secret\_name](#input\_sds\_secret\_name) | The name of the secret for the certificate. | `string` | `null` | no |
| <a name="input_subject_alternative_names_exact"></a> [subject\_alternative\_names\_exact](#input\_subject\_alternative\_names\_exact) | The exact SAN to match in the request header | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | An arbitrary map of tags that can be added to all resources. | `map(string)` | `{}` | no |
| <a name="input_text_format"></a> [text\_format](#input\_text\_format) | The text format. | `string` | `null` | no |
| <a name="input_timeout_millis"></a> [timeout\_millis](#input\_timeout\_millis) | The amount of time to wait when receiving a response from the health check in milliseconds. | `number` | `5000` | no |
| <a name="input_tls_enforce"></a> [tls\_enforce](#input\_tls\_enforce) | Whether the policy is enforced. The default is True, if a value isn’t specified. | `bool` | `true` | no |
| <a name="input_tls_mode"></a> [tls\_mode](#input\_tls\_mode) | The mode for the listener’s Transport Layer Security (TLS) configuration. Must be one of DISABLED, PERMISSIVE, STRICT. | `string` | `"DISABLED"` | no |
| <a name="input_tls_ports"></a> [tls\_ports](#input\_tls\_ports) | If you specify a listener port other than 443, you must specify this field. | `list(number)` | `[]` | no |
| <a name="input_trust_acm_certificate_authority_arns"></a> [trust\_acm\_certificate\_authority\_arns](#input\_trust\_acm\_certificate\_authority\_arns) | One or more Amazon Resource Names (ARNs). | `list(string)` | `[]` | no |
| <a name="input_trust_backend_file_certificate_chain"></a> [trust\_backend\_file\_certificate\_chain](#input\_trust\_backend\_file\_certificate\_chain) | The certificate chain for the certificate. | `string` | `null` | no |
| <a name="input_trust_backend_sds_secret_name"></a> [trust\_backend\_sds\_secret\_name](#input\_trust\_backend\_sds\_secret\_name) | The name of the secret for the certificate. | `string` | `null` | no |
| <a name="input_trust_file_certificate_chain"></a> [trust\_file\_certificate\_chain](#input\_trust\_file\_certificate\_chain) | The certificate chain for the certificate. | `string` | `"default"` | no |
| <a name="input_trust_sds_secret_name"></a> [trust\_sds\_secret\_name](#input\_trust\_sds\_secret\_name) | The name of the secret for the certificate. | `string` | `null` | no |
| <a name="input_unhealthy_threshold"></a> [unhealthy\_threshold](#input\_unhealthy\_threshold) | The number of consecutive failed health checks that must occur before considering a target unhealthy. | `number` | `2` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | ARN of the virtual gateway |
| <a name="output_id"></a> [id](#output\_id) | ID of the virtual gateway |
| <a name="output_name"></a> [name](#output\_name) | Name of the virtual gateway |
<!-- END_TF_DOCS -->

## Module Development

### Pre-Requisites

The following commands should be available on your system:

- `asdf` or `mise`
- `make`
- `python3` (for pre-commit)

Additionally, your `git` user and email must be configured. Run the `make configure` command from the root of the repository to ensure that you meet these requirements.

### Pre-Commit hooks

The [.pre-commit-config.yaml](.pre-commit-config.yaml) file defines certain `pre-commit` hooks that are relevant to Terraform and Golang, as well as some common linting tasks. These will be configured for you when you run `make configure`.

### Local Validation

You should validate the changes you make to any module locally, prior to pushing your changes in a branch to GitHub.

1. Ensure that you have run `make configure` successfully.

2. Ensure you are signed into the appropriate cloud provider (e.g. AWS or Azure) for the module under test in your current console session.

3. Run the Terraform and Golang linters with the following command:

```
make lint
```

4. Once you have satisfied the linters, the following command will build example infrastructure in your configured cloud, run the tests, and then tear down the infrastructure it created:

```
make test
```

The pre-commit validations, as well as the `make lint` and `make test` targets, will all be performed in CI. Running these validations locally prior to opening a PR helps ensure a smooth review and merge process.

### Review & Merge Process

Once your change has been tested locally and your branch pushed up, open a new Pull Request for your branch to the default (main) branch of this repository.

The title of your Pull Request will determine the version bump for this change, and the title must be in [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/#specification) format in order to merge. A breaking change will trigger a major version bump, a feature will trigger a minor version bump, and all other types will trigger a patch version bump.

Ensure your CI workflows are passing; seek approval from teammates and address any feedback; seek any explicit approvals required by the CODEOWNERS file. You may merge the PR as soon as all requirements are met, and a new release and tag will be automatically created for you.

### Automatic Updates

The shared configuration and workflow files in this repository are largely managed through the [launch-terraform-skeleton](https://github.com/launchbynttdata/launch-terraform-skeleton) repository. Outside of perhaps the `.gitignore` to account for specific files being generated by certain Terraform modules (e.g. Lambda functions), there should not be much cause to update these files on a per-repo basis, and making changes to them individually is discouraged.

If desired, you can check for and run these updates locally in a branch if you have the `copier` tool installed. Some example commands are included below:

```
# Check for updates, optionally checking prerelease versions
copier check-update [--prereleases]

# Run an update, using default answers if there are any. We use tasks, which requires --trust to be set.
copier update --defaults --trust [--prereleases]

# Recopy from the source, and --overwrite all templated files in the process
copier recopy --defaults --trust --overwrite [--prereleases]
```

Automatic updates will run through a scheduled workflow, and if the post-update tests are successful, the Pull Request created will automatically merge. Conflicts in the update or failures to test may leave a Pull Request outstanding, which needs to be addressed by a Launch Engineer.
