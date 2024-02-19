# syntax=docker/dockerfile:1
FROM node:20-bullseye-slim
WORKDIR /app
ENV TERM xterm-256color

RUN apt-get update && apt-get upgrade -y

COPY --chown=node:node package.json .
RUN corepack enable && pnpm install

COPY --chown=node:node . .
RUN pnpm build

EXPOSE 3000
USER node
CMD ["pnpm", "start"]
