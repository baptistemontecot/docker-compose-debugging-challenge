# 🐳 Docker Compose Debugging Challenge
>*Diagnostiquer et réparer des stacks avec Docker Compose qui ne fonctionnent pas*

## 📋 Exercices disponibles
| Branche                               | Exercice       | Stack                             | Statut      |
|---------------------------------------|----------------|-----------------------------------|-------------|
| `fix/wordpress-mysql`                 | Exercice 1     | WordPress + MySQL + phpMyAdmin    | ✅ Corrigé   |
| `fix/nextcloud-postgresql`            | Exercice 2     | Nextcloud + PostgreSQL + Redis    | ✅ Corrigé   |
| `fix/mattermost-postgres`             | Exercice 3     | Mattermost + PostgreSQL           | ✅ Corrigé   |
| `fix/stack-elk`                       | Exercice 4     | Elasticsearch + Logstash + Kibana | ✅ Corrigé   |
| `fix/kong-microservices-architecture` | Exercice 5     | Kong Gateway                      | 🚧 En cours |
| `main`                                | Base du projet | Documentation et instructions     | 📚          |

### 🚀 Navigation entre les branches
*Changer de branche*
```bash
  # Aller sur l'exercice WordPress + MySQL
  git checkout fix/wordpress-mysql

  # Aller sur l'exercice Nextcloud + PostgreSQL
  git checkout fix/nextcloud-postgresql
  
  # Aller sur l'exercice Mattermost + PostgreSQL
  git checkout fix/mattermost-postgres
  
  # Aller sur l'exercice Stack ELK (Elasticsearch + Logstash + Kibana)
  git checkout fix/stack-elk
  
  # Aller sur l'exercice Architecture Microservices avec Kong Gateway
  git checkout fix/kong-microservices-architecture

  # Retourner à la branche principale
  git checkout main
```

*Voir toutes les branches*
```bash
  git branch -a
```

## 📖 Documentation
Chaque branche contient son propre `README.md` détaillé avec :
- 🔧 Problèmes identifiés
- ✨ Solutions apportées
- 🧪 Procédures de test
- 📊 Architecture finale

Chaque exercice est une mise en situation réelle de debugging DevOps 🚀