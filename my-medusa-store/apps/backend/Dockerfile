FROM node:20-alpine

# Force IPv4 for all Node.js network calls
ENV NODE_OPTIONS=--dns-result-order=ipv4first

WORKDIR /app

# Copy only package files first to utilise Docker cache
COPY package.json package-lock.json* ./

# Install with legacy peer deps and increased timeout
RUN npm install --legacy-peer-deps --fetch-timeout=120000

# Copy the rest of the application
COPY . .

# Build the app (remove if no "build" script)
RUN npm run build || true

EXPOSE 9000

CMD sh -c "npx medusa db:migrate && npx medusa start"
