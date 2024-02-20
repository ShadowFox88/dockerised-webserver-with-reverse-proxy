# syntax=docker/dockerfile:1
FROM node:latest AS build
WORKDIR /app

RUN ["apt-get", "update"]
RUN ["apt-get", "upgrade", "-y"]

COPY --chown=node:node package.json .
RUN ["corepack", "enable"]
RUN ["pnpm", "install"]

COPY --chown=node:node . .
RUN ["pnpm", "build", "--no-lint"]

FROM node:20.11.1-bookworm-slim AS runtime
WORKDIR /app

COPY --chown=node:node --from=build /app/node_modules node_modules
COPY --chown=node:node --from=build /app .

EXPOSE 3000
USER node
ENTRYPOINT ["npm", "start"]
