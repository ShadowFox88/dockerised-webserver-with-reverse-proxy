# Webserver + Reverse Proxy (as Docker) Container(s)

The meat of this is in all Docker- and Caddy-related (reverse proxy of choice)
files, which I've listed below for ease of use:

-   [`.dockerignore`](https://github.com/cyrus01337/webserver-plus-reverse-proxy-container/blob/main/.dockerignore)
-   [`Caddyfile`](https://github.com/cyrus01337/webserver-plus-reverse-proxy-container/blob/main/Caddyfile)
-   [`Dockerfile`](https://github.com/cyrus01337/webserver-plus-reverse-proxy-container/blob/main/Dockerfile)
-   [`compose.yaml`](https://github.com/cyrus01337/webserver-plus-reverse-proxy-container/blob/main/compose.yaml)

Those will be all that's needed to recreate this project using your own
webserver, reverse proxy through a single depedency - Docker.

### Setup

If you need to install Docker, this is ripped straight from the [Docker
docs](https://docs.docker.com/engine/install/ubuntu/#install-using-the-convenience-script)
(don't use for prod by the way):

```sh
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh ./get-docker.sh
```

```sh
git clone https://github.com/cyrus01337/webserver-plus-reverse-proxy-container.git
cd webserver-plus-reverse-proxy-container

docker compose up
```

And here's a convenience script that does it all for you:

```sh
if ! which docker &> /dev/null; then
    curl -fsSL https://get.docker.com | bash
fi

git clone https://github.com/cyrus01337/webserver-plus-reverse-proxy-container.git
cd webserver-plus-reverse-proxy-container
docker compose up
```
