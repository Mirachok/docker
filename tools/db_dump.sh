#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."

DOCKER=(docker)
if ! docker ps >/dev/null 2>&1; then DOCKER=(sudo docker); fi
COMPOSE=("${DOCKER[@]}" compose)

"${COMPOSE[@]}" exec -T mysql sh -lc '
mysqldump -u root -p"$MYSQL_ROOT_PASSWORD" \
  --databases "$MYSQL_DATABASE" \
  --single-transaction --routines --triggers \
  --default-character-set=utf8mb4 --no-tablespaces
' > apt_db_dump.sql

echo "OK: $(pwd)/apt_db_dump.sql"
