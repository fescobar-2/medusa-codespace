FROM node:20-alpine

ENV NODE_OPTIONS=--dns-result-order=ipv4first

WORKDIR /app

COPY package.json package-lock.json* ./
RUN npm install --legacy-peer-deps --fetch-timeout=120000

COPY . .

COPY startup.sh /app/startup.sh
RUN chmod +x /app/startup.sh

EXPOSE 9000

CMD ["/app/startup.sh"]
