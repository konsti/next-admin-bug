# syntax=docker.io/docker/dockerfile:1

FROM node:22-bookworm AS base

# Rebuild the source code only when needed
FROM base AS installer
# Add support for build-time env variables
ARG BUILD_ENV
WORKDIR /app
ENV NEXT_TELEMETRY_DISABLED=1

# First install the dependencies (as they change less often)
COPY package.json package-lock.json ./
RUN npm install

# Build the project with build-time env variables
COPY . .
RUN if [ -n "$BUILD_ENV" ]; then eval "$BUILD_ENV"; fi && \
    npm run prisma:generate && \
    npm run build

# Production image, copy all the files and run next
FROM base AS runner
WORKDIR /app
ENV NEXT_TELEMETRY_DISABLED=1
ENV NODE_ENV=production

RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs

# # Automatically leverage output traces to reduce image size
# # https://nextjs.org/docs/advanced-features/output-file-tracing
COPY --from=installer --chown=nextjs:nodejs /app/.next/standalone ./
COPY --from=installer --chown=nextjs:nodejs /app/.next/static ./.next/static
COPY --from=installer --chown=nextjs:nodejs /app/public ./public
COPY --from=installer --chown=nextjs:nodejs /app/prisma/dev.db ./

USER nextjs

EXPOSE 3000

ENV PORT=3000
ENV HOSTNAME="0.0.0.0"

CMD ["node", "server.js"]
