FROM node:20-alpine

ENV NODE_OPTIONS=--dns-result-order=ipv4first

WORKDIR /app

COPY package.json package-lock.json* ./
RUN npm install --legacy-peer-deps --fetch-timeout=120000

COPY . .

# Build admin panel
RUN npx medusa build

# Move admin files to the location Medusa expects
RUN cp -r /app/.medusa/server/public/admin/* /app/.medusa/server/public/ 2>/dev/null || true

# Verify
RUN test -f /app/.medusa/server/public/index.html && echo "Admin build OK" || echo "Admin build missing"

COPY startup.sh /app/startup.sh
RUN chmod +x /app/startup.sh

EXPOSE 9000

CMD ["/app/startup.sh"]
