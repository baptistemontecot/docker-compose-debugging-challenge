# 💬 EXERCICE 3 : Mattermost + PostgreSQL

## Problèmes identifiés

- Erreur SSL : `"pq: SSL is not enabled on the server"`
- Erreur d’authentification : `"password authentication failed for user 'mattermost'"`
- Connexion refusée : `"dial tcp: connect: connection refused"`

## Corrections apportées

1. Configuration SSL désactivée

Ajout du paramètre `?sslmode=disable` dans la chaîne de connexion :

```yaml
environment:
  - MM_SQLSETTINGS_DATASOURCE=postgres://mattermost:password@postgres:5432/mattermost?sslmode=disable&connect_timeout=10
```

2. Cohérence des variables d’environnement

Alignement parfait entre les services Mattermost et PostgreSQL :

- Utilisateur : `POSTGRES_USER`
- Mot de passe : `'POSTGRES_PASSWORD`
- Base de données : `POSTGRES_BD`

3. Architecture réseau sécurisée

- Réseau `database` dédié pour PostgreSQL
- Isolation des services sensibles
- Pas d’exposition du port PostgreSQL vers l’extérieur

## Tests et vérification

1. Déploiement

```bash
  # Supprimer les volumes existants (si nécessaire)
  docker-compose down -v

  # Démarrer la stack
  docker-compose up -d
```

2. Vérification des logs

```bash
  # Surveiller les logs Mattermost
  docker logs -f mattermost

  # Vérifier PostgreSQL
  docker logs postgres
```

3. Test de connectivité

```bash
  # Accès à l'interface web
  http://localhost:8065

  # Test de la base de données
  docker exec -it postgres psql -U mattermost -d mattermost -c "\l"
```

## Utilisation

Première connexion

1.	Accéder à http://localhost:8065
2.	Cliquer sur “View in Browser”
3.	Créer le compte administrateur
4.	Configurer votre première équipe