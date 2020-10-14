dnf install go -y

git clone https://github.com/sorintlab/stolon.git
cd stolon/  
make
make install
stolonctl --version

mkdir -p /var/log/stolon
chown -R postgres:postgres /var/log/stolon

# Only first node
stolonctl --cluster-name kv-gc-tp-dbcl01 --store-backend consul init
# end

# Check cluster status
stolonctl --cluster-name kv-gc-tp-dbcl01 --store-backend consul status

dnf install -y jq
dnf clean all

curl -v http://localhost:8500/v1/kv/?recurse | jq .

systemctl enable stolon-sentinel.service
systemctl enable stolon-keeper.service
systemctl enable stolon-proxy.service
