logical_product_family               = "terratest"
logical_product_service              = "vgwtest"
tls_mode                             = "STRICT"
listener_port                        = "443"
tls_enforce                          = true
trust_acm_certificate_authority_arns = []
tags = {
  "env" : "gotest",
  "creator" : "terratest",
  "provisioner" : "Terraform",
}
