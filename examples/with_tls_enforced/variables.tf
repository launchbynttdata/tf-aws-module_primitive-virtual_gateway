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

variable "naming_prefix" {
  description = "Prefix for the provisioned resources."
  type        = string
  default     = "demo-app"
}

variable "environment" {
  description = "Environment in which the resource should be provisioned like dev, qa, prod etc."
  type        = string
  default     = "dev"
}

variable "region" {
  description = "AWS Region in which the infra needs to be provisioned"
  type        = string
  default     = "us-east-2"
}

## Virtual Gateway

variable "tls_enforce" {
  description = "Whether the policy is enforced. The default is True, if a value isn’t specified."
  type        = bool
  default     = true
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

variable "listener_port" {
  description = "The port mapping information for the listener."
  type        = number
  default     = 8080
}

variable "trust_acm_certificate_authority_arns" {
  description = "One or more Amazon Resource Names (ARNs)."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "An arbitrary map of tags that can be added to all resources."
  type        = map(string)
  default     = {}
}
