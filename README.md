# uddr_docker_relay

This repository contains a Dockerfile that spins up a container running a BIND server. This BIND server relays queries to dnscrypt-proxy, which resolves the queries via DoH (DNS-over-HTTPS) using custom resolvers. The instructions provided demonstrate how to configure Vercara's UltraDDR servers, though the setup should work with any recursive DNS servers.

## Prerequisites

- Docker installed on your machine.

## Installation and Configuration

1. Clone this repository:
   ```bash
   git clone https://github.com/sbarbett/uddr_docker_relay
   ```
2. Build the Docker container:
	```bash
	docker build -t dns-relay .
	```
3. Run the container, passing your UDDR client UID (install key) as an environment variable and opening port 53:
	```bash
	docker run -d --name dns-relay -e CLIENT_ID=your_client_id -p 53:53/udp -p 53:53/tcp dns-relay
	```

Now, you can test it by using dig or nslookup to perform a DNS query:

```
dig @localhost example.com
```

## License

This script is provided under the MIT License. See the LICENSE.md for the full declaration.
