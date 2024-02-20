# syntax=docker/dockerfile:1
FROM node:20.11.1-bookworm-slim AS base
WORKDIR /app

RUN ["corepack", "enable"]
RUN --mount=type=cache,id=apt-get,target=/var/cache/apt ["apt-get", "update"]
RUN --mount=type=cache,id=apt-get,target=/var/cache/apt ["apt-get", "upgrade", "-y"]
COPY --chown=node:node . .

FROM base AS prod-deps
RUN --mount=type=cache,id=pnpm,target=/pnpm/store ["pnpm", "install", "--prod", "--frozen-lockfile"]

FROM base AS build
RUN --mount=type=cache,id=pnpm,target=/pnpm/store ["pnpm", "install", "--frozen-lockfile"]
RUN ["pnpm", "build", "--no-lint"]

FROM base
COPY --from=prod-deps /app/node_modules node_modules
COPY --from=build /app/.next .next
EXPOSE 3000
USER node
ENTRYPOINT ["npm", "start"]
