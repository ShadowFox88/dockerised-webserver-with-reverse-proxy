# syntax=docker/dockerfile:1
FROM caddy:latest
WORKDIR /app
ENV TERM=xterm-256color
COPY Caddyfile /etc/caddy/Caddyfile
