#!/bin/sh
set -e

echo "Running migrations..."
/app/bin/migrate

echo "Starting server..."
exec /app/bin/server 