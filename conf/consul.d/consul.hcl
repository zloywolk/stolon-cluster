bind_addr = <ip>
advertise_addr = <ip>

datacenter = "<dc_name>"
data_dir = "/var/lib/consul"

encrypt = <consul keygen>

verify_incoming = false
verify_outgoing = false
verify_server_hostname = false

node_name = "<node>"

retry_join = [
  <nodes>
]

enable_syslog = false
log_level = "INFO"
log_file = "/var/log/consul/consul.log"
log_rotate_duration = "24h"
log_rotate_max_files = 7

acl = {
  enabled = true
  default_policy = "allow"
  enable_token_persistence = true
}

performance {
  raft_multiplier = 1
}
