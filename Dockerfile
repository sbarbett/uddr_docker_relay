# Use Ubuntu as the base image
FROM ubuntu:latest

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Update and install BIND9, dnscrypt-proxy, nano, wget, ca-certificates, and Python for script execution
RUN apt-get update && \
    apt-get install -y bind9 dnscrypt-proxy nano wget ca-certificates python3 python3-pip && \
    mkdir -p /var/log/dnscrypt-proxy/ && \
    chmod 755 /var/log/dnscrypt-proxy/

# Download the ultraddr root CA certificate
RUN wget https://ca.ultraddr.com/cert/pem/ultraddr-ca-cert.pem -O /usr/local/share/ca-certificates/ultraddr.crt && \
    update-ca-certificates

# Copy the Python script and entrypoint script into the container
COPY stampgen.py /stampgen.py
COPY entrypoint.sh /entrypoint.sh

# Ensure the scripts are executable
RUN chmod +x /entrypoint.sh /stampgen.py

# Copy BIND and dnscrypt-proxy configuration files into the container
COPY named.conf.options /etc/bind/named.conf.options

# Expose DNS port
EXPOSE 53/udp
EXPOSE 53/tcp

# Set the entrypoint script to run on container start
ENTRYPOINT ["/entrypoint.sh"]

