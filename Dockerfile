FROM node:22.12.0-alpine AS runnerbase

FROM node:22.12.0-alpine AS base
# Check https://github.com/nodejs/docker-node/tree/b4117f9333da4138b03a546ec926ef50a31506c3#nodealpine to understand why libc6-compat might be needed.
RUN apk update
RUN apk add --no-cache libc6-compat jq
# Option 3: Use corepack (recommended for Node 16.10+)
RUN corepack enable && corepack prepare yarn@stable --activate
# install even though part of package.json in root - used later when rubo not installed
RUN yarn -v
RUN npm -v

FROM base AS versions
# Set working directory
WORKDIR /app
# Install dependencies based on the preferred package manager
COPY package.json yarn.lock ./
# ensure to NOT include version in package.json for dep install.
# this ensures that deps are cached even though version tag changes.
RUN jq 'del(.version)' package.json > package_temp.json && mv package_temp.json package.json

# Add lockfile and package.json's of isolated subworkspace
FROM base AS deps
WORKDIR /app
COPY --from=versions app/package.json app/yarn.lock ./
RUN yarn install --frozen-lockfile

# Add lockfile and package.json's of isolated subworkspace
FROM base AS builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .
ENV NEXT_TELEMETRY_DISABLED=1
RUN yarn build

FROM runnerbase AS runner
WORKDIR /app
ENV NODE_ENV=production
ENV NEXT_TELEMETRY_DISABLED=1
RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs
COPY --from=builder /app/public ./public
# Automatically leverage output traces to reduce image size
# https://nextjs.org/docs/advanced-features/output-file-tracing
COPY --from=builder --chown=nextjs:nodejs /app/.next/standalone ./
COPY --from=builder --chown=nextjs:nodejs /app/.next/static ./.next/static
COPY --from=builder /app .
#COPY --from=deps /app/node_modules ./node_modules
#COPY tsconfig.orm.json ./tsconfig.orm.json
#COPY tsconfig.json ./tsconfig.json
USER nextjs
EXPOSE 3000
ENV PORT=3000
CMD HOSTNAME="0.0.0.0" node server.js