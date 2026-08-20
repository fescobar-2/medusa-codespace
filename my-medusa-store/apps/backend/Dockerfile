FROM node:20-alpine

ENV NODE_OPTIONS=--dns-result-order=ipv4first

WORKDIR /app

COPY package.json package-lock.json* ./
RUN npm install --legacy-peer-deps --fetch-timeout=120000

COPY . .

# Build the admin panel (uses @medusajs/admin-bundler now installed)
RUN npm run build

# Verify the build output exists
RUN test -f /app/.medusa/server/public/index.html && echo "Admin build successful" || (echo "Admin build failed - searching..." && find /app -name "index.html" 2>/dev/null)

COPY startup.sh /app/startup.sh
RUN chmod +x /app/startup.sh

EXPOSE 9000

CMD ["/app/startup.sh"]
