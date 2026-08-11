FROM node:20-alpine

# Force IPv4 for all Node.js network calls
ENV NODE_OPTIONS=--dns-result-order=ipv4first

WORKDIR /app

# Copy only package files first to utilise Docker cache
COPY package.json package-lock.json* ./

# Install dependencies
RUN npm install --legacy-peer-deps --fetch-timeout=120000

# Copy the rest of the application
COPY . .

# Build the admin panel explicitly and ensure output goes to the right place
RUN npx medusa build --admin-only

# Verify the build output exists (helps debugging)
RUN ls -la /app/.medusa/server/public/ 2>/dev/null || echo "Admin build directory not found, checking alternative paths..."
RUN ls -la /app/build/ 2>/dev/null || echo "No /app/build directory"
RUN find /app -name "index.html" -type f 2>/dev/null || echo "No index.html found anywhere"

# Copy startup script
COPY startup.sh /app/startup.sh
RUN chmod +x /app/startup.sh

EXPOSE 9000

CMD ["/app/startup.sh"]
