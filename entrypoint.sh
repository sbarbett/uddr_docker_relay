#!/bin/bash

# Generate a new dnscrypt-proxy.toml file using the provided client ID
echo "Generating new dnscrypt-proxy.toml with client ID: $CLIENT_ID"
python3 /stampgen.py "$CLIENT_ID"

# Ensure the newly generated dnscrypt-proxy.toml file is moved to the correct location
mv dnscrypt-proxy.toml /etc/dnscrypt-proxy/dnscrypt-proxy.toml

# Start dnscrypt-proxy in the background
dnscrypt-proxy -config /etc/dnscrypt-proxy/dnscrypt-proxy.toml &

# Start BIND in the foreground
exec named -g

# Keep the container running
tail -f /dev/null
