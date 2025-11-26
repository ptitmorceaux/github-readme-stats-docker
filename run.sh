#!/bin/bash

# ============================================
# CONFIGURATION
# ============================================
LOG_FILE="update.log"
REPO_URL="https://github.com/anuraghazra/github-readme-stats.git"
ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
TARGET_DIR="$ROOT_DIR/app"

DOCKER_COMPOSE_FILE="$ROOT_DIR/docker-compose.local.yml"
# DOCKER_COMPOSE_FILE="$ROOT_DIR/docker-compose.cloudflared.yml" # I use cloudflared proxy tunnel for external access

set -e
exec 3>&1
exec >"$LOG_FILE" 2>&1

get_time() {
    date '+%d/%m/%Y %H:%M:%S'
}

log_step() {
    local timestamp=$(get_time)
    echo "------------------------------------------------"
    echo "[$timestamp] $1"
    echo -e "\033[1;34m[$timestamp] $1\033[0m" >&3
}

error_handler() {
    local timestamp=$(get_time)
    echo "[$timestamp] ❌ ÉCHEC DU SCRIPT"
    echo -e "\033[1;31m[$timestamp] ❌ Une erreur est survenue ! Consultez $LOG_FILE.\033[0m" >&3
}
trap 'error_handler' ERR

# ============================================
# DÉBUT
# ============================================

log_step "🗑️  Suppression de l'ancien dossier…"
rm -rf "$TARGET_DIR"

log_step "📦 Clonage du dépôt…"
git clone "$REPO_URL" "$TARGET_DIR"

log_step "🗑️  Suppression du .git…"
rm -rf "$TARGET_DIR/.git"

log_step "🐳 Reconstruction du conteneur Docker…"
docker compose -f "$DOCKER_COMPOSE_FILE" up -d --build

log_step "🧹 Nettoyage des images…"
docker image prune -f

log_step "✅ Terminé !"
echo -e "\033[1;32m[$(get_time)] 🎉 Mise à jour terminée !\033[0m" >&3
exit 0