#!/usr/bin/env bash
set -e

# Ensure app is ready
php artisan config:clear || true
php artisan route:clear || true

# Run migrations on startup (safe for demo)
php artisan migrate --force

# Start web server
php -S 0.0.0.0:${PORT:-10000} -t public