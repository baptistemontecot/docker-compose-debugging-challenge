# 🐳 Exercice 1 – WordPress + MySQL

- Création du fichier docker-compose.yaml
- Lancement de la commande de build
```bash
  cp .env .env.local
  docker-compose up -d --build
```

## Problèmes identifiés
- MySQL ne démarrait pas (erreurs de variables d'environnement)
- WordPress affichait des erreurs de connexion à la base
- Log Erreur :
  - 2025-08-29 07:26:34+00:00 [ERROR] [Entrypoint]: Database is uninitialized and password option is not specified

## Corrections apportées
- Ajout dans le service mysql de la variable suivante
  - `MYSQL_ROOT_PASSWORD: wordpress` (Password for root access)
- Lancement de la commande de suppression des containers pour éviter les conflits
- Sécuriser les variables d’environnement sensibles (mots de passe) dans un fichier `.env` distinct, non versionné
- Créer le fichier .env et le remplir
```bash
  cp .env.local .env
```

- Utiliser un réseau Docker de type bridge pour la communication interne entre les containers afin d’isoler les services et renforcer la sécurité.
```bash
  docker-compose down
```
- Lancement de la commande de build
```bash
  docker-compose up -d --build
```

## Procédure de test
1. Lancer la commande : `docker-compose up -d`
2. Vérifier l'accès à http://localhost:8080 (WordPress) et http://localhost:8081 (phpMyAdmin)
3. Création du Wordpress via le Wordpress CLI et vérification de la création des tables `wp_` dans la base de données.

## Limites et recommandations
- Pas de prise en charge d'un environnement (linux/arm64/v8), proposer le choix lors de l'installation
- phpmyadmin The requested image's platform (linux/amd64) does not match the detected host platform (linux/arm64/v8) and no specific platform was requested