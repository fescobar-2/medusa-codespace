echo "Starting Medusa..."
export PORT=${PORT:-9000}
npx medusa start --port ${PORT:-10000} --host 0.0.0.0
