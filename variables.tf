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

variable "acm_certificate_arn" {
  description = "ARN for the private certificate issued for the Virtual Gateway."
  type        = string
  default     = null
}

variable "access_log_path" {
  description = "The file path to write access logs to."
  type        = string
  default     = "/dev/stdout"
}

variable "backend_file_certificate_chain" {
  description = "The certificate chain for the certificate."
  type        = string
  default     = null
}

variable "backend_file_private_key" {
  description = "The private key for a certificate stored on the file system of the virtual node that the proxy is running on."
  type        = string
  default     = null
}

variable "backend_sds_secret_name" {
  description = "The name of the secret for the certificate."
  type        = string
  default     = null
}

variable "backend_subject_alternative_names_exact" {
  description = "The exact names to match."
  type        = list(string)
  default     = []
}

variable "file_certificate_chain" {
  description = "The certificate chain for the certificate."
  type        = string
  default     = null
}

variable "file_private_key" {
  description = "The private key for a certificate stored on the file system of the virtual node that the proxy is running on."
  type        = string
  default     = null
}

variable "grpc_max_requests" {
  description = "Maximum number of inflight requests Envoy can concurrently support across all backends."
  type        = number
  default     = null
}

variable "health_check_path" {
  description = "The destination path for the health check request."
  type        = string
  default     = "/"
}

variable "health_check_port" {
  description = "The destination port for the health check request."
  type        = number
  default     = 8080
}

variable "health_check_protocol" {
  description = "The protocol for the health check request. Must be one of [http http2 grpc]."
  type        = string
  default     = "http"
}

variable "healthy_threshold" {
  description = "The number of consecutive successful health checks required before considering an unhealthy target healthy."
  type        = number
  default     = 5
}

variable "http_max_connections" {
  description = "Maximum number of outbound TCP connections Envoy can establish concurrently with all hosts in upstream cluster."
  type        = number
  default     = null
}

variable "http_max_pending_requests" {
  description = "Maximum number of inflight requests Envoy can concurrently support across all backends."
  type        = number
  default     = null
}

variable "http2_max_requests" {
  description = "Maximum number of inflight requests Envoy can concurrently support across all backends."
  type        = number
  default     = null
}

variable "interval_millis" {
  description = "The time period in milliseconds between each health check execution."
  type        = number
  default     = 30000
}

variable "json_key" {
  description = "The JSON key."
  type        = string
  default     = null
}

variable "json_value" {
  description = "The JSON value."
  type        = string
  default     = null
}

variable "listener_port" {
  description = "The port mapping information for the listener."
  type        = number
  default     = 8080
}

variable "listener_protocol" {
  description = "The protocol for the port mapping. Must be one of [http http2 grpc]."
  type        = string
  default     = "http"
}

variable "mesh_name" {
  description = "The name of the service mesh to create the virtual gateway in. Must be between 1 and 255 characters in length."
  type        = string
}

variable "name" {
  description = "The name to use for the virtual gateway."
  type        = string
}

variable "sds_secret_name" {
  description = "The name of the secret for the certificate."
  type        = string
  default     = null
}

variable "subject_alternative_names_exact" {
  description = "The exact SAN to match in the request header"
  type        = list(string)
  default     = []
}

variable "text_format" {
  description = "The text format."
  type        = string
  default     = null
}

variable "timeout_millis" {
  description = "The amount of time to wait when receiving a response from the health check in milliseconds."
  type        = number
  default     = 5000
}

variable "tls_enforce" {
  description = "Whether the policy is enforced. The default is True, if a value isn’t specified."
  type        = bool
  default     = true
}

variable "client_tls_enforce" {
  description = "Whether the mTLS client policy is enforced. The default is false"
  type        = bool
  default     = false
}

variable "tls_mode" {
  description = "The mode for the listener’s Transport Layer Security (TLS) configuration. Must be one of DISABLED, PERMISSIVE, STRICT."
  type        = string
  default     = "DISABLED"
}

variable "tls_ports" {
  description = "If you specify a listener port other than 443, you must specify this field."
  type        = list(number)
  default     = []
}

variable "trust_acm_certificate_authority_arns" {
  description = "One or more Amazon Resource Names (ARNs)."
  type        = list(string)
  default     = []
}

variable "trust_backend_file_certificate_chain" {
  description = "The certificate chain for the certificate."
  type        = string
  default     = null
}

variable "trust_backend_sds_secret_name" {
  description = "The name of the secret for the certificate."
  type        = string
  default     = null
}

variable "trust_file_certificate_chain" {
  description = "The certificate chain for the certificate."
  type        = string
  default     = "default"
}

variable "trust_sds_secret_name" {
  description = "The name of the secret for the certificate."
  type        = string
  default     = null
}

variable "unhealthy_threshold" {
  description = "The number of consecutive failed health checks that must occur before considering a target unhealthy."
  type        = number
  default     = 2
}

variable "tags" {
  description = "An arbitrary map of tags that can be added to all resources."
  type        = map(string)
  default     = {}
}
