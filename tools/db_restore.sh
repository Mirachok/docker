#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."

FILE="${1:-apt_db_dump.sql}"
if [ ! -f "$FILE" ]; then
  echo "Файл не найден: $FILE"
  exit 1
fi

DOCKER=(docker)
if ! docker ps >/dev/null 2>&1; then DOCKER=(sudo docker); fi
COMPOSE=("${DOCKER[@]}" compose)

cat "$FILE" | "${COMPOSE[@]}" exec -T mysql sh -lc 'mysql -u root -p"$MYSQL_ROOT_PASSWORD"'

echo "OK: imported $FILE"
