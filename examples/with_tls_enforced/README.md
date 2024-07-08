# End-to-End encryption Example
This example demonstrates creating a Virtual Gateway with `enforce_tls=true`. The gateway terminates the SSL and starts a new SSL connection to route traffic to the backend.

We need a `Private CA` to provision certificates. If an existing CA is not passed as inputs, the example with create one.

## Provider requirements
Make sure a `provider.tf` file is created with the below contents inside the `examples/with_tls_enforced` directory
```shell
provider "aws" {
  profile = "<profile_name>"
  region  = "<aws_region>"
}
# Used to create a random integer postfix for aws resources
provider "random" {}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0, <= 1.5.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.6 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_random"></a> [random](#provider\_random) | 3.6.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_app_mesh"></a> [app\_mesh](#module\_app\_mesh) | terraform.registry.launch.nttdata.com/module_primitive/appmesh/aws | ~> 1.0 |
| <a name="module_private_ca"></a> [private\_ca](#module\_private\_ca) | terraform.registry.launch.nttdata.com/module_primitive/private_ca/aws | ~> 1.0 |
| <a name="module_private_cert"></a> [private\_cert](#module\_private\_cert) | terraform.registry.launch.nttdata.com/module_primitive/acm_private_cert/aws | ~> 1.0 |
| <a name="module_appmesh_virtual_gateway"></a> [appmesh\_virtual\_gateway](#module\_appmesh\_virtual\_gateway) | ../.. | n/a |

## Resources

| Name | Type |
|------|------|
| [random_integer.priority](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_logical_product_family"></a> [logical\_product\_family](#input\_logical\_product\_family) | (Required) Name of the product family for which the resource is created.<br>    Example: org\_name, department\_name. | `string` | `"launch"` | no |
| <a name="input_logical_product_service"></a> [logical\_product\_service](#input\_logical\_product\_service) | (Required) Name of the product service for which the resource is created.<br>    For example, backend, frontend, middleware etc. | `string` | `"ecs"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment in which the resource should be provisioned like dev, qa, prod etc. | `string` | `"dev"` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS Region in which the infra needs to be provisioned | `string` | `"us-east-2"` | no |
| <a name="input_tls_enforce"></a> [tls\_enforce](#input\_tls\_enforce) | Whether the policy is enforced. The default is True, if a value isn’t specified. | `bool` | `true` | no |
| <a name="input_tls_mode"></a> [tls\_mode](#input\_tls\_mode) | The mode for the listener’s Transport Layer Security (TLS) configuration. Must be one of DISABLED, PERMISSIVE, STRICT. | `string` | `"DISABLED"` | no |
| <a name="input_tls_ports"></a> [tls\_ports](#input\_tls\_ports) | If you specify a listener port other than 443, you must specify this field. | `list(number)` | `[]` | no |
| <a name="input_listener_port"></a> [listener\_port](#input\_listener\_port) | The port mapping information for the listener. | `number` | `8080` | no |
| <a name="input_trust_acm_certificate_authority_arns"></a> [trust\_acm\_certificate\_authority\_arns](#input\_trust\_acm\_certificate\_authority\_arns) | One or more Amazon Resource Names (ARNs). | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | An arbitrary map of tags that can be added to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | ID of the virtual gateway |
| <a name="output_arn"></a> [arn](#output\_arn) | ARN of the virtual gateway |
| <a name="output_name"></a> [name](#output\_name) | Name of the virtual gateway |
| <a name="output_mesh_name"></a> [mesh\_name](#output\_mesh\_name) | Name of the Mesh |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
