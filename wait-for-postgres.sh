#!/bin/bash
set -e

DB_HOST="${DB_HOST:-db}"
DB_PORT="${DB_PORT:-5432}"

echo "Waiting for PostgreSQL on $DB_HOST:$DB_PORT..."

# pg_isready не требует указания БД
until pg_isready -h "$DB_HOST" -p "$DB_PORT" -U "$POSTGRES_USER" 2>/dev/null; do
    echo "PostgreSQL is not ready, wait"
    sleep 2
done

# Дополнительная проверка, что БД существует и работает
echo "PostgreSQL ready! Work with nginx..."
exec "$@"