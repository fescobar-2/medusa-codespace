#!/bin/sh
echo "Running migrations..."
npx medusa db:migrate

echo "Starting Medusa..."
npx medusa start --port 10000 --host 0.0.0.0
