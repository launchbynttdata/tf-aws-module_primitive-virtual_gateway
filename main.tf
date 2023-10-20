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

resource "aws_appmesh_virtual_gateway" "this" {
  name      = var.name
  mesh_name = var.mesh_name

  spec {
    listener {
      port_mapping {
        port     = var.listener_port
        protocol = var.listener_protocol
      }

      dynamic "connection_pool" {
        for_each = try(
          coalesce(
            var.grpc_max_requests,
            var.http_max_connections,
            var.http_max_pending_requests,
            var.http2_max_requests
          ),
          null
        ) != null ? [1] : []
        content {

          dynamic "grpc" {
            for_each = var.grpc_max_requests != null ? [1] : []
            content {
              max_requests = var.grpc_max_requests
            }
          }

          dynamic "http" {
            for_each = var.http_max_connections != null || var.http_max_pending_requests != null ? [1] : []
            content {
              max_connections      = var.http_max_connections
              max_pending_requests = var.http_max_pending_requests
            }
          }

          dynamic "http2" {
            for_each = var.http2_max_requests != null ? [1] : []
            content {
              max_requests = var.http2_max_requests
            }
          }
        }
      }

      health_check {
        healthy_threshold   = var.healthy_threshold
        interval_millis     = var.interval_millis
        protocol            = var.health_check_protocol
        timeout_millis      = var.timeout_millis
        unhealthy_threshold = var.unhealthy_threshold
        path                = var.health_check_path
        port                = var.health_check_port
      }

      dynamic "tls" {
        for_each = var.tls_enforce ? [1] : []
        content {
          certificate {
            dynamic "acm" {
              for_each = var.acm_certificate_arn != null ? [1] : []
              content {
                certificate_arn = var.acm_certificate_arn
              }
            }
            dynamic "file" {
              for_each = var.file_certificate_chain != null || var.file_private_key != null ? [1] : []
              content {
                certificate_chain = var.file_certificate_chain
                private_key       = var.file_private_key
              }
            }
            dynamic "sds" {
              for_each = var.sds_secret_name != null ? [1] : []
              content {
                secret_name = var.sds_secret_name
              }
            }
          }

          mode = var.tls_mode

          # client cert validation
          dynamic "validation" {
            for_each = var.client_tls_enforce ? [1] : []
            content {
              dynamic "subject_alternative_names" {
                for_each = length(var.subject_alternative_names_exact) > 0 ? [1] : []
                content {
                  match {
                    exact = var.subject_alternative_names_exact
                  }
                }

              }
              trust {
                dynamic "file" {
                  for_each = var.trust_file_certificate_chain == null ? [1] : []
                  content {
                    certificate_chain = var.trust_file_certificate_chain
                  }
                }

                dynamic "sds" {
                  for_each = var.trust_sds_secret_name != null ? [1] : []
                  content {
                    secret_name = var.trust_sds_secret_name
                  }
                }
              }
            }
          }
        }
      }
    }

    backend_defaults {
      client_policy {
        dynamic "tls" {
          for_each = var.tls_enforce ? [1] : []
          content {

            dynamic "certificate" {
              for_each = var.client_tls_enforce ? [1] : []
              content {
                dynamic "file" {
                  for_each = var.backend_file_certificate_chain != null || var.backend_file_private_key != null ? [1] : []
                  content {
                    certificate_chain = var.backend_file_certificate_chain
                    private_key       = var.backend_file_private_key
                  }
                }

                dynamic "sds" {
                  for_each = var.backend_sds_secret_name != null ? [1] : []
                  content {
                    secret_name = var.backend_sds_secret_name
                  }
                }
              }

            }
            enforce = var.tls_enforce
            ports   = var.tls_ports

            validation {
              dynamic "subject_alternative_names" {
                for_each = length(var.backend_subject_alternative_names_exact) > 0 ? [1] : []
                content {
                  match {
                    exact = var.backend_subject_alternative_names_exact
                  }
                }
              }

              trust {
                dynamic "acm" {
                  for_each = var.trust_acm_certificate_authority_arns != null ? [1] : []
                  content {
                    certificate_authority_arns = var.trust_acm_certificate_authority_arns
                  }
                }
                dynamic "file" {
                  for_each = var.trust_backend_file_certificate_chain != null ? [1] : []
                  content {
                    certificate_chain = var.trust_backend_file_certificate_chain
                  }
                }
                dynamic "sds" {
                  for_each = var.trust_backend_sds_secret_name != null ? [1] : []
                  content {
                    secret_name = var.trust_backend_sds_secret_name
                  }
                }
              }
            }
          }
        }
      }
    }

    logging {
      access_log {
        file {
          dynamic "format" {
            for_each = var.json_key != null || var.json_value != null || var.text_format != null ? [1] : []
            content {
              dynamic "json" {
                for_each = var.json_key != null && var.json_value != null ? [1] : []
                content {
                  key   = var.json_key
                  value = var.json_value
                }
              }
              text = var.text_format != null ? var.text_format : null
            }
          }
          path = var.access_log_path
        }
      }
    }
  }

  tags = local.tags
}
