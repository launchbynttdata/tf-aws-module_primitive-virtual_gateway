name      = "tf-ingress"
mesh_name = "<app_mesh_name>"

trust_acm_certificate_authority_arns = ["<private_ca_arn>"]
tls_enforce                          = true
health_check_path                    = "/"
health_check_port                    = 443
health_check_protocol                = "http"

listener_port     = 443
listener_protocol = "http"

acm_certificate_arn = "<acm_private_cert_arn>"
tls_mode            = "STRICT"
tls_ports           = []
text_format         = <<-EOF
[%START_TIME%] "%REQ(:METHOD)% %REQ(X-ENVOY-ORIGINAL-PATH?:PATH)% %PROTOCOL%" %RESPONSE_CODE% %RESPONSE_FLAGS% %BYTES_RECEIVED% %BYTES_SENT% %DURATION% %RESP(X-ENVOY-UPSTREAM-SERVICE-TIME)% "%REQ(X-FORWARDED-FOR)%" "%REQ(USER-AGENT)%" "%REQ(X-REQUEST-ID)%" "%REQ(:AUTHORITY)%" "%UPSTREAM_HOST%"
EOF
