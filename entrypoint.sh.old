#!/bin/bash

# Parse the SERVER_STAMPS environment variable to create dnscrypt-proxy.toml
IFS=',' read -ra STAMPS <<< "$SERVER_STAMPS"
cat > /etc/dnscrypt-proxy/dnscrypt-proxy.toml << EOF
server_names = ['custom-uddr1', 'custom-uddr2']
listen_addresses = ['127.0.0.5:53']

log_file = '/var/log/dnscrypt-proxy/dnscrypt-proxy.log'
log_level = 2
EOF

for i in "${!STAMPS[@]}"; do
    cat >> /etc/dnscrypt-proxy/dnscrypt-proxy.toml << EOF
[static.'custom-uddr$((i+1))']
stamp = "${STAMPS[$i]}"
EOF
done

# Start dnscrypt-proxy in the background
dnscrypt-proxy -config /etc/dnscrypt-proxy/dnscrypt-proxy.toml &

# Start BIND in the foreground
exec named -g

