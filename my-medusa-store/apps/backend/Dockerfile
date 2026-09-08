FROM node:20-alpine AS builder

ENV NODE_OPTIONS=--dns-result-order=ipv4first

WORKDIR /app

COPY package.json package-lock.json* ./

RUN npm install --legacy-peer-deps --fetch-timeout=120000

COPY . .

RUN npm run build


FROM node:20-alpine

ENV NODE_ENV=production
ENV NODE_OPTIONS=--dns-result-order=ipv4first

WORKDIR /app

COPY --from=builder /app/.medusa/server ./

RUN npm install --omit=dev --legacy-peer-deps --fetch-timeout=120000

COPY startup.sh /app/startup.sh
RUN chmod +x /app/startup.sh

EXPOSE 10000

CMD ["/app/startup.sh"]
