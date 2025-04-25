#!/bin/sh
set -e

echo "Current user: $(whoami)"
echo "DATABASE_PATH: $DATABASE_PATH"

# Extract the directory path from DATABASE_PATH
DB_DIR=$(dirname "$DATABASE_PATH")

# Create database directory if it doesn't exist
echo "Ensuring database directory exists..."
mkdir -p "$DB_DIR"

# Install sqlite3 if not present
if ! command -v sqlite3 >/dev/null 2>&1; then
    echo "Installing sqlite3..."
    apt-get update && apt-get install -y sqlite3
fi

# Create and initialize SQLite database
echo "Initializing SQLite database..."
if [ ! -f "$DATABASE_PATH" ]; then
    echo "Creating new database file..."
    sqlite3 "$DATABASE_PATH" "PRAGMA journal_mode=WAL; VACUUM;"
fi

# Ensure proper permissions for both directory and database file
echo "Setting proper permissions..."
chown -R nobody:root "$DB_DIR"
chown nobody:root "$DATABASE_PATH"
chmod 755 "$DB_DIR"
chmod 644 "$DATABASE_PATH"

# List permissions for debugging
ls -la "$DB_DIR"
ls -la "$DATABASE_PATH"

echo "Running migrations..."
/app/bin/migrate

echo "Starting server..."
exec /app/bin/server 