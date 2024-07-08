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

resource "random_integer" "priority" {
  min = 10000
  max = 50000
}

module "app_mesh" {
  source = "git::https://github.com/launchbynttdata/tf-aws-module_primitive-appmesh?ref=1.0.0"

  name = local.app_mesh_name
}

module "private_ca" {
  source = "git::https://github.com/launchbynttdata/tf-aws-module_primitive-private_ca?ref=1.0.0"

  count = length(var.trust_acm_certificate_authority_arns) == 0 ? 1 : 0

  naming_prefix = local.naming_prefix
  region        = var.region
  environment   = var.environment

}

module "private_cert" {
  source = "git::https://github.com/launchbynttdata/tf-aws-module_primitive-acm_private_cert?ref=1.0.0"

  # Private CA is created if not passed as input
  private_ca_arn = length(var.trust_acm_certificate_authority_arns) == 0 ? module.private_ca[0].private_ca_arn : var.trust_acm_certificate_authority_arns[0]
  domain_name    = "test.${local.namespace_name}"
}

module "appmesh_virtual_gateway" {
  source = "../.."

  name                                 = local.name
  mesh_name                            = local.app_mesh_name
  tls_enforce                          = var.tls_enforce
  tls_mode                             = var.tls_mode
  tls_ports                            = var.tls_ports
  listener_port                        = var.listener_port
  health_check_port                    = var.listener_port
  acm_certificate_arn                  = module.private_cert.certificate_arn
  trust_acm_certificate_authority_arns = length(var.trust_acm_certificate_authority_arns) > 0 ? var.trust_acm_certificate_authority_arns : [module.private_ca[0].private_ca_arn]

  tags = var.tags

  depends_on = [module.app_mesh]
}
