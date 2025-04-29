{{/*
Vault annotations
*/}}
{{- define "octavia.vaultAnnotations" -}}
vault.hashicorp.com/role: "{{ .Values.vault.role }}"
vault.hashicorp.com/agent-inject: "true"
vault.hashicorp.com/agent-pre-populate-only: "true"
vault.hashicorp.com/agent-inject-status: "update"
vault.hashicorp.com/secret-volume-path-secrets.conf: /etc/octavia/octavia.conf.d
vault.hashicorp.com/agent-inject-secret-secrets.conf: "{{ .Values.vault.settings_secret }}"
vault.hashicorp.com/agent-inject-template-secrets.conf: |
  {{ print "{{- with secret \"" .Values.vault.settings_secret "\" -}}" }}
  {{ print "[DEFAULT]" }}
  {{ print "transport_url={{ .Data.data.transport_url }}" }}
  {{ print "[database]" }}
  {{ print "connection={{ .Data.data.database_connection }}" }}
  {{ print "[keystone_authtoken]" }}
  {{ print "password={{ .Data.data.keystone_password }}" }}
  {{ print "[service_auth]" }}
  {{ print "password={{ .Data.data.keystone_password }}" }}
  {{ print "[health_manager]" }}
  {{ print "heartbeat_key={{ .Data.data.heartbeat_key }}" }}
  {{ print "[certificates]" }}
  {{ print "server_certs_key_passphrase={{ .Data.data.server_certs_key_passphrase }}" }}
  {{ print "ca_private_key_passphrase={{ .Data.data.ca_private_key_passphrase }}" }}
  {{ print "{{- end -}}" }}
vault.hashicorp.com/secret-volume-path-client_cert_and_key.pem: /etc/octavia/certs
vault.hashicorp.com/agent-inject-secret-client_cert_and_key.pem: "{{ .Values.vault.certs }}"
vault.hashicorp.com/secret-volume-path-client_ca_cert.pem: /etc/octavia/certs
vault.hashicorp.com/agent-inject-secret-client_ca_cert.pem: "{{ .Values.vault.certs }}"
vault.hashicorp.com/secret-volume-path-server_ca_cert.pem: /etc/octavia/certs
vault.hashicorp.com/agent-inject-secret-server_ca_cert.pem: "{{ .Values.vault.certs }}"
vault.hashicorp.com/secret-volume-path-server_ca_key.pem: /etc/octavia/certs
vault.hashicorp.com/agent-inject-secret-server_ca_key.pem: "{{ .Values.vault.certs }}"
vault.hashicorp.com/agent-inject-template-client_cert_and_key.pem: |
  {{ print "{{- with secret \"" .Values.vault.certs "\" -}}" }}
  {{ print "{{ .Data.data.client_cert_and_key }}" }}
  {{ print "{{- end -}}" }}
vault.hashicorp.com/agent-inject-template-client_ca_cert.pem: |
  {{ print "{{- with secret \"" .Values.vault.certs "\" -}}" }}
  {{ print "{{ .Data.data.client_ca_cert }}" }}
  {{ print "{{- end -}}" }}
vault.hashicorp.com/agent-inject-template-server_ca_cert.pem: |
  {{ print "{{- with secret \"" .Values.vault.certs "\" -}}" }}
  {{ print "{{ .Data.data.server_ca_cert }}" }}
  {{ print "{{- end -}}" }}
vault.hashicorp.com/agent-inject-template-server_ca_key.pem: |
  {{ print "{{- with secret \"" .Values.vault.certs "\" -}}" }}
  {{ print "{{ .Data.data.server_ca_key }}" }}
  {{ print "{{- end -}}" }}
vault.hashicorp.com/secret-volume-path-ovn_cacert.pem: /etc/octavia/ovn
vault.hashicorp.com/agent-inject-secret-ovn_cacert.pem: "{{ .Values.vault.ovn_certs }}"
vault.hashicorp.com/secret-volume-path-ovn_cert.pem: /etc/octavia/ovn
vault.hashicorp.com/agent-inject-secret-ovn_cert.pem: "{{ .Values.vault.ovn_certs }}"
vault.hashicorp.com/secret-volume-path-ovn_key.pem: /etc/octavia/ovn
vault.hashicorp.com/agent-inject-secret-ovn_key.pem: "{{ .Values.vault.ovn_certs }}"
vault.hashicorp.com/agent-inject-template-ovn_cacert.pem: |
  {{ print "{{- with secret \"" .Values.vault.ovn_certs "\" -}}" }}
  {{ print "{{ .Data.data.cacert }}" }}
  {{ print "{{- end -}}" }}
vault.hashicorp.com/agent-inject-template-ovn_cert.pem: |
  {{ print "{{- with secret \"" .Values.vault.ovn_certs "\" -}}" }}
  {{ print "{{ .Data.data.cert }}" }}
  {{ print "{{- end -}}" }}
vault.hashicorp.com/agent-inject-template-ovn_key.pem: |
  {{ print "{{- with secret \"" .Values.vault.ovn_certs "\" -}}" }}
  {{ print "{{ .Data.data.key }}" }}
  {{ print "{{- end -}}" }}
{{- end }}
