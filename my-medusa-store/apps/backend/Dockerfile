FROM node:20-alpine

# Force IPv4 for all Node.js network calls (prevents registry timeouts)
ENV NODE_OPTIONS=--dns-result-order=ipv4first

WORKDIR /app

# Copy only package files first to utilise Docker cache
COPY package.json package-lock.json* ./

# Install dependencies with legacy peer deps and increased timeout
RUN npm install --legacy-peer-deps --fetch-timeout=120000

# Copy the rest of the application
COPY . .

# Build the admin panel (required for production)
RUN npx medusa build

# Copy and make executable the startup script
COPY startup.sh /app/startup.sh
RUN chmod +x /app/startup.sh

EXPOSE 9000

# Start with migrations, admin user creation, and server
CMD ["/app/startup.sh"]
