#!/bin/sh
echo "Running migrations..."
npx medusa db:migrate

echo "Checking for admin user..."
ADMIN_EXISTS=$(node -e "
const { Pool } = require('pg');
const p = new Pool({ connectionString: process.env.DATABASE_URL });
p.query(\"SELECT COUNT(*) FROM public.user WHERE email = 'admin@test.com'\")
  .then(r => console.log(r.rows[0].count))
  .catch(() => console.log('0'))
  .finally(() => p.end());
")

if [ "$ADMIN_EXISTS" = "0" ]; then
  echo "Creating admin user..."
  npx @medusajs/medusa-cli user -e admin@test.com -p supersecret
else
  echo "Admin user already exists, skipping creation."
fi

echo "Starting Medusa..."
export PORT=${PORT:-9000}
npx medusa start
