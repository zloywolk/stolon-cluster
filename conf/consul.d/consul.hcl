bind_addr = "192.168.0.31"
advertise_addr = "192.168.0.31"

datacenter = "dc1"
data_dir = "/var/lib/consul"
encrypt = "Zv4iEQ7jDFtYcAgIcUSJmS3qMqmsBmyTO5n7NQB7o6M="
verify_incoming = false
verify_outgoing = false
verify_server_hostname = false
retry_join = [
  "pdb01",
  "pdb02",
  "pdb03"
]

acl = {
  enabled = true
  default_policy = "allow"
  enable_token_persistence = true
}

performance {
  raft_multiplier = 1
}