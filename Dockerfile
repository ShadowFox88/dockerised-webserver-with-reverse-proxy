# syntax=docker/dockerfile:1
FROM node:latest
WORKDIR /app
ENV TERM=xterm-256color

COPY package.json /app
RUN corepack enable && pnpm install

COPY . /app
RUN pnpm build

EXPOSE 3000
CMD ["pnpm", "start"]
