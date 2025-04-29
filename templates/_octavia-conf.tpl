{{- define "octavia-conf" }}

[DEFAULT]

[quotas]
default_load_balancer_quota=0
default_listener_quota=100
default_member_quota=200
default_pool_quota=100
default_health_monitor_quota=-1

[controller_worker]
amp_ssh_key_name=octavia-ssh-key
amp_flavor_id={{ .Values.conf.controller_worker.amp_flavor_id }}
amp_image_tag=octavia
amp_image_owner_id={{ .Values.conf.controller_worker.amp_image_owner_id }}
amp_secgroup_list={{ .Values.conf.controller_worker.amp_secgroup_list }}
amp_boot_network_list={{ .Values.conf.controller_worker.amp_boot_network_list }}
loadbalancer_topology=ACTIVE_STANDBY
client_ca=/etc/octavia/certs/client_ca_cert.pem
workers=4

[health_manager]
controller_ip_port_list={{ .Values.conf.health_manager.controller_ip_port_list }}
bind_ip=0.0.0.0
health_update_threads=4
stats_update_threads=4

[service_auth]
auth_url={{ .Values.conf.keystone.auth_url }}
username={{ .Values.conf.keystone.username }}
project_name=octavia
user_domain_name=Default
project_domain_name=Default
auth_type=password

[nova]
enable_anti_affinity=True
anti_affinity_policy=soft-anti-affinity

[oslo_messaging]
topic=octavia-rpc

[oslo_messaging_rabbit]
ssl=True
rabbit_quorum_queue=true
rabbit_transient_quorum_queue=true
rabbit_stream_fanout=true
rabbit_qos_prefetch_count=1

[oslo_middleware]
enable_proxy_headers_parsing=true

[oslo_policy]
policy_file=/etc/octavia/policy.yaml

[nectar]
restrict_zones=True
default_availability_zone={{ .Values.conf.nectar.default_availablity_zone }}

[haproxy_amphora]
http_proxy={{ .Values.conf.haproxy_amphora.http_proxy }}
client_cert=/etc/octavia/certs/client_cert_and_key.pem
server_ca=/etc/octavia/certs/server_ca_cert.pem

[api_settings]
bind_host=0.0.0.0
bind_port={{ .Values.api.port }}
auth_strategy=keystone
healthcheck_enabled=True
enabled_provider_drivers=amphora:The Octavia Amphora driver.,octavia:Deprecated alias of the Octavia Amphora driver.,ovn:Octavia OVN driver.

[healthcheck]
backends=disable_by_file
disable_by_file_path=/etc/octavia/healthcheck_disable

[certificates]
cert_generator=local_cert_generator
ca_certificate=/etc/octavia/certs/server_ca_cert.pem
ca_private_key=/etc/octavia/certs/server_ca_key.pem

[database]
connection_recycle_time=600

[cache]
backend=oslo_cache.memcache_pool
enabled=True
{{- if .Values.conf.keystone.memcached_servers }}
memcache_servers={{ join "," .Values.conf.keystone.memcached_servers }}
{{- end }}

[keystone_authtoken]
auth_url={{ .Values.conf.keystone.auth_url }}
www_authenticate_uri={{ .Values.conf.keystone.auth_url }}
username={{ .Values.conf.keystone.username }}
project_name={{ .Values.conf.keystone.project_name }}
user_domain_name=Default
project_domain_name=Default
auth_type=password
{{- if .Values.conf.keystone.memcached_servers }}
memcached_servers={{ join "," .Values.conf.keystone.memcached_servers }}
{{- end }}
service_type=load-balancer

[driver_agent]
enabled_provider_agents=ovn

[ovn]
ovn_nb_connection={{ .Values.conf.ovn.ovn_nb_connection }}
ovn_sb_connection={{ .Values.conf.ovn.ovn_sb_connection }}
ovn_nb_private_key=/etc/octavia/ovn/ovn_key.pem
ovn_nb_certificate=/etc/octavia/ovn/ovn_cert.pem
ovn_nb_ca_cert=/etc/octavia/ovn/ovn_cacert.pem
ovn_sb_private_key=/etc/octavia/ovn/ovn_key.pem
ovn_sb_certificate=/etc/octavia/ovn/ovn_cert.pem
ovn_sb_ca_cert=/etc/octavia/ovn/ovn_cacert.pem

{{- end }}
