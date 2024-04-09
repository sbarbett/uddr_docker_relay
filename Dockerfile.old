# Use Ubuntu as the base image
FROM ubuntu:latest

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Add build-time variables for DNSCrypt server stamps
ARG SERVER_STAMPS

# Pass the server stamps to the environment so it can be used by the entrypoint script
ENV SERVER_STAMPS=$SERVER_STAMPS

# Update and install BIND9, dnscrypt-proxy, nano, wget, and ca-certificates for editing
RUN apt-get update && \
    apt-get install -y bind9 dnscrypt-proxy nano wget ca-certificates && \
    mkdir -p /var/log/dnscrypt-proxy/ && \
    chmod 755 /var/log/dnscrypt-proxy/

# Download the ultraddr root CA certificate
RUN wget https://ca.ultraddr.com/cert/pem/ultraddr-ca-cert.pem -O /usr/local/share/ca-certificates/ultraddr.crt && \
    update-ca-certificates

# Copy BIND and dnscrypt-proxy configuration files into the container
COPY named.conf.options /etc/bind/named.conf.options
# COPY dnscrypt-proxy.toml /etc/dnscrypt-proxy/dnscrypt-proxy.toml # This is generated dynamically now

# Expose DNS port
EXPOSE 53/udp
EXPOSE 53/tcp

# Copy entrypoint script and make it executable
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Set the entrypoint script to run on container start
ENTRYPOINT ["/entrypoint.sh"]
