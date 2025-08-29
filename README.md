# 📁  Exercice 2 – Nextcloud + PostgreSQL

- Création du fichier docker-compose.yaml
- Lancement de la commande de build
```bash
  cp .env .env.local
  docker-compose up -d --build
```

## Problèmes identifiés
- Aucun problème d'accès à Nextcloud
- Base PostgreSQL inaccessible
  - Service "postgres" refers to undefined volume postgres_data: invalid compose project
  - Ajout de `postgres_data:` dans le volume du `docker-compose.yaml`
- Absence de cache Redis pour optimiser les performances
- Manque de health checks pour surveiller l’état des services

## Corrections apportées

### Configuration PostgreSQL
- Suppression de l’exposition du port `5432` pour renforcer la sécurité
- Configuration des variables d’environnement
- Ajout d’un health check avec `pg_isready`

### Intégration Redis comme cache
- Ajout du service Redis avec persistance des données
- Configuration de Redis comme gestionnaire de cache et de sessions pour Nextcloud
- Montage d’un volume pour la persistance (`./redis:/data`)
- Les données Redis sont sauvegardées automatiquement dans le fichier `dump.rdb` situé dans le dossier `./redis/` du projet.
- Commandes de sauvegarde manuelle :
```bash
  docker exec -it redis redis-cli SAVE
```

### Health checks complets
- PostgreSQL : Vérification de la disponibilité avec `pg_isready`
- Redis : Test de connectivité avec `redis-cli ping`
- Nextcloud : Vérification de l’endpoint `/status.php`
- Configuration des dépendances avec `condition: service_healthy`

### Sécurisation réseau
- Utilisation d’un réseau Docker bridge dédié (`cloud`)
- Isolation des services dans le réseau interne
- Exposition sélective des ports uniquement pour Nextcloud

### Tests et vérification
1. Lancement de la stack

```bash
  docker-compose up -d --build
```

2. Vérification des health checks

```bash
  docker ps --format "table {{.Names}}\t{{.Status}}"
```

3. Test de connectivité Redis

```bash
  # Test depuis le container Nextcloud
  docker exec -it redis redis-cli
  127.0.0.1:6379> PING
```

Résultat attendu : `PONG`

4. Vérification de l’intégration cache
```bash
  # Vérifier la configuration Redis dans les logs Nextcloud
  docker logs nextcloud | grep -i redis
```

Message attendu : `"Configuring Redis as session handler"`

5. Accès aux services
- Nextcloud : http://localhost:8080
- Vérification du statut : http://localhost:8080/status.php


- Utiliser un réseau Docker de type bridge pour la communication interne entre les containers afin d’isoler les services et renforcer la sécurité.
```bash
  docker-compose down
```
- Lancement de la commande de build
```bash
  docker-compose up -d --build
```