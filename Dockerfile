# syntax=docker/dockerfile:1
FROM node:20.11.1-bookworm-slim AS base
WORKDIR /app
RUN ["corepack", "enable"]
COPY . .

FROM base AS prod-deps
RUN --mount=type=cache,id=pnpm,target=/pnpm/store ["pnpm", "install", "--prod", "--frozen-lockfile"]

FROM base AS build
RUN --mount=type=cache,id=pnpm,target=/pnpm/store ["pnpm", "install", "--frozen-lockfile"]
RUN ["pnpm", "build", "--no-lint"]

FROM gcr.io/distroless/nodejs20-debian12 AS runtime
WORKDIR /app
COPY --from=base /app .
COPY --from=build /app/.next .next
COPY --from=prod-deps /app/node_modules node_modules
CMD [".next/standalone/server.js"]
