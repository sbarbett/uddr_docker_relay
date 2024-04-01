# uddr_docker_relay

This repository contains a Dockerfile that spins up a container running a BIND server. This BIND server relays queries to dnscrypt-proxy, which resolves the queries via DoH (DNS-over-HTTPS) using custom resolvers. The instructions provided demonstrate how to configure Vercara's UltraDDR servers, though the setup should work with any recursive DNS servers.

## Prerequisites

- Docker installed on your machine.

## Generating DNSCrypt Stamps

Before running the script, generate your DNSCrypt stamps:

1. Visit [DNSCrypt](https://dnscrypt.info/stamps/).
2. Change the **Protocol** to **DNS-over-HTTPS**.
3. Generate the first stamp:
   - **IP**: `204.74.103.5`
   - **Host**: `rcsv1.ddr.ultradns.com`
   - **Path**: `/{your_uddr_client_id}` (Replace `{your_uddr_client_id}` with your unique client ID)
4. Generate the second stamp:
   - **IP**: `204.74.122.5`
   - **Host**: `rcsv2.ddr.ultradns.com`
   - **Path**: Use the same path as the first stamp.

## Installation and Configuration

1. Clone this repository:
   ```bash
   git clone https://github.com/sbarbett/uddr_docker_relay
   ```
2. Build the Docker container, passing your stamps as arguments (separated by a comma):
	```bash
	docker build --build-arg SERVER_STAMPS="sdns://AgcAAAAAAAAADDIwNC43NC4xMDMuNQAWcmNzdjEuZGRyLnVsdHJhZG5zLmNvbSUvNTRhYTAwYWEtZjE2NS00YmQyLTg3MzktODFmNTNjOWJiOTEx,sdns://AgcAAAAAAAAADDIwNC43NC4xMjIuNQAWcmNzdjIuZGRyLnVsdHJhZG5zLmNvbSUvNTRhYTAwYWEtZjE2NS00YmQyLTg3MzktODFmNTNjOWJiOTEx" -t dns-relay .
	```
3. Run the container, making sure to open port 53:
	```bash
	docker run -d --name dns-relay -p 53:53/udp -p 53:53/tcp dns-relay
	```

Now, you can test it by using dig or nslookup to perform a DNS query:

```
dig @localhost example.com
```

## License

This script is provided under the MIT License. See the LICENSE.md for the full declaration.
