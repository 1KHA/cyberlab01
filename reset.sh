#!/bin/bash
# Recreate the lab container (new random tampered file). Notes in ./work are kept.
cd "$(dirname "$0")"
docker compose down
docker compose up -d --build
echo "Lab reset. Enter with: docker compose exec integrity-lab bash"
