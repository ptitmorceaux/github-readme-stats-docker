# GitHub Readme Stats - Self-Hosted

<p align="center">
  <strong>🐳 Auto-hébergement Docker du projet
  <br>
  <a href="https://github.com/anuraghazra/github-readme-stats">github-readme-stats</a></strong>, de <a href="https://github.com/anuraghazra">@anuraghazra</a>
</p>

<p align="center">
  <a href="https://github.com/anuraghazra/github-readme-stats">
    <img src="https://img.shields.io/badge/Original-github--readme--stats-blue?logo=github" alt="Original Project">
  </a>
  <a href="https://github.com/anuraghazra">
    <img src="https://img.shields.io/badge/Author-@anuraghazra-green?logo=github" alt="Author">
  </a>
  <a href="https://github.com/anuraghazra/github-readme-stats/blob/master/LICENSE">
    <img src="https://img.shields.io/badge/License-MIT-yellow.svg" alt="License">
  </a>
</p>

---

## Description

Déployez votre propre instance de GitHub Readme Stats avec Docker. Cette version dockerisée vous permet de contourner les limitations de taux de l'API GitHub imposées sur l'instance publique Vercel.

## Prérequis

- Docker
- Docker Compose
- Un token d'accès personnel GitHub (PAT) de type **Classic**

## Configuration du Token GitHub

### Création du Token Classic

1. Allez sur [GitHub Settings → Developer Settings → Personal Access Tokens → Tokens (classic)](https://github.com/settings/tokens)
2. Cliquez sur **"Generate new token"** → **"Generate new token (classic)"**
3. **Permissions requises** (scopes à cocher) :
   - ✅ `repo` (cocher **toutes** les sous-options)
   - ✅ `read:user`
   - ✅ `user:email`
4. Cliquez sur **"Generate token"** et copiez-le immédiatement

> **⚠️ Important** : Le token ne sera affiché qu'une seule fois. Conservez-le en lieu sûr.

### Configuration du fichier `.env`

Créez un fichier `.env` à la racine du projet avec le contenu suivant :

```env
# Token GitHub (Classic PAT avec permissions : repo, read:user, user:email)
PAT_1=ghp_votre_token_github_ici

# Durée du cache en secondes (min: 21600 = 6h, max: 86400 = 24h)
CACHE_SECONDS=21600
```

## Installation et Démarrage

### Utilisation locale (par défaut)

Le script `run.sh` est configuré par défaut pour un déploiement local sur le port 9000.

1. Rendez le script exécutable :
```bash
chmod +x run.sh
```

2. Lancez le script :
```bash
./run.sh
```

Le service sera disponible sur `http://localhost:9000`

### Utilisation avec Cloudflare Tunnel

Si vous utilisez Cloudflare Tunnel (comme `cloudflared`) pour exposer vos services en ligne, modifiez le fichier `run.sh` :

```bash
# Commentez cette ligne :
# DOCKER_COMPOSE_FILE="$ROOT_DIR/docker-compose.local.yml"

# Décommentez cette ligne :
DOCKER_COMPOSE_FILE="$ROOT_DIR/docker-compose.cloudflared.yml"
```

Le fichier `docker-compose.cloudflared.yml` utilise le réseau externe `cloudflared_proxy` au lieu d'exposer un port.

## Utilisation

Une fois le service démarré, vous pouvez utiliser les mêmes URL que la version Vercel officielle :

### Pour un déploiement local

```markdown
![GitHub Stats](http://localhost:9000/api?username=votre_username)
![Top Langs](http://localhost:9000/api/top-langs/?username=votre_username)
```

### Pour un déploiement avec domaine personnalisé

```markdown
![GitHub Stats](https://votre-domaine.com/api?username=votre_username)
![Top Langs](https://votre-domaine.com/api/top-langs/?username=votre_username)
```

## Gestion du service

### Arrêter le service

```bash
docker compose -f docker-compose.local.yml down
# ou
docker compose -f docker-compose.cloudflared.yml down
```

### Voir les logs

```bash
docker logs github-readme-stats
```

### Mise à jour

Relancez simplement le script `run.sh` qui :
1. Supprime l'ancienne version
2. Clone la dernière version du dépôt
3. Reconstruit le conteneur Docker
4. Nettoie les images inutilisées

## Fonctionnement du script `run.sh`

Le script automatise :
- Le clonage du projet `github-readme-stats`
- La construction de l'image Docker
- Le démarrage du conteneur
- Le nettoyage des anciennes images

Les logs sont sauvegardés dans `update.log`.

## Ressources système

Les limites par défaut du conteneur sont :
- **RAM** : 200 MB maximum
- **CPU** : 50% d'un cœur maximum
- **Processus** : 50 maximum

Ces valeurs peuvent être ajustées dans les fichiers `docker-compose.*.yml`.

## Licence et Crédits

Ce projet de déploiement Docker est sous licence MIT. Voir [LICENSE](LICENSE) pour plus de détails.

Basé sur [github-readme-stats](https://github.com/anuraghazra/github-readme-stats) par [@anuraghazra](https://github.com/anuraghazra), également sous licence MIT.

## Documentation complète

Pour plus d'informations sur les options disponibles (thèmes, personnalisation, etc.), consultez la [documentation officielle](https://github.com/anuraghazra/github-readme-stats/blob/master/readme.md).
