# 🔧 EXERCICE 4 : Stack ELK (Elasticsearch + Logstash + Kibana) (Niveau : Avancé)

## Problèmes identifiés

Configuration d’une stack ELK complète avec Filebeat pour centraliser et analyser les logs système. Cette configuration
corrige les problèmes de mémoire Elasticsearch et d’ordre de démarrage de containers identifiés dans l’exercice.

## Corrections apportées

1. Problèmes de mémoire Elasticsearch
- Heap JVM augmentée : De 512MB à 1GB (`ES_JAVA_OPTS=-Xms1g -Xmx1g`)
- Limites conteneur : 2GB avec réservation de 1GB
- Configuration vm.max_map_count : [Elastic JVM Settings](https://www.elastic.co/docs/reference/elasticsearch/jvm-settings)

2. Ordre de démarrage des services
- Health checks complets sur tous les services critiques
- Dépendances conditionnelles : `condition: service_healthy`
- Délais de grâce : `start_period` adapté pour chaque service

3. Configuration des ports
- Séparation TCP/UDP : Port `5000/tcp` et `5001/udp` pour éviter les conflits
- API monitoring : Port `9600 pour les health checks Logstash

4. Ressources recommandées
- RAM : Minimum 4GB alloués à Docker (recommandé : 6-8GB)
- CPU : 2 cores minimum 
- Stockage : 10GB d’espace libre pour les données Elasticsearch

## Tests et vérification

1. Lancement de la stack

```bash
  # Supprimer les volumes existants (si nécessaire)
  docker-compose down -v

  # Démarrer la stack
  docker-compose up -d
```

2. Surveillance des logs

```bash
  # Logs Elasticsearch
  docker-compose logs -f elasticsearch

  # Logs de tous les services
  docker-compose logs -f
```

3. Test de connectivité

```bash
  # Test Elasticsearch
  curl "http://localhost:9200/_cluster/health?pretty"

  # Test Kibana
  curl "http://localhost:5601/api/status"

  # Test Logstash
  curl "http://localhost:9600"
```

## Tests d’ingestion de logs

1. Configuration Kibana
- Accéder à http://localhost:5601
- Aller dans Stack Management > Index Patterns
- Créer un pattern `log-*`, `metrics-*`
- Visualiser dans Discover

## 🗂️ Structure du projet
```
├── .env                   # Variables d'environnement
├── docker-compose.yml     # Configuration Docker Compose
├── filebeat.yml           # Configuration Filebeat
├── logstash.conf          # Pipeline Logstash
├── logstash.yaml          # Configuration Logstash
├── metricbeat.yml         # Configuration Metricbeat
├── filebeat_ingest_data/  # Dossier pour logs Filebeat
├── logstash_ingest_data/  # Dossier pour logs Logstash
└── README.md
```

## Services configurés
- Setup : Génération automatique des certificats SSL
- Elasticsearch : Base de données avec sécurité activée
- Kibana : Interface web de visualisation
- Logstash : Pipeline de traitement des logs
- Filebeat : Collecte de logs (containers + fichiers)
- Metricbeat : Monitoring de la stack et Docker

## 📊 Utilisation

1. Premier accès à Kibana
- Aller sur http://localhost:5601
- Se connecter avec `elastic` / `${ELASTIC_PASSWORD}`
- Aller dans Stack Monitoring pour voir la santé du cluster
- Aller dans Discover pour explorer les données

2. Création de Data Views
Dans Kibana :
- Aller dans Stack Management > Data Views
- Créer des data views pour :
  - `filebeat-*` (logs Filebeat)
  - `logstash-*` (logs Logstash)
  - `metricbeat-*` (métriques)

## 📈 Monitoring et dashboards

1. Stack Monitoring
- Dans Kibana, aller dans Stack Monitoring
- Activer la surveillance pour tous les composants
- Configurer les alertes recommandées

2. Dashboards par défaut
Docker : Métriques containers via Metricbeat
System : Métriques système host
Logs : Stream de logs via Filebeat/Logstash
3. Sécurité
Configuration actuelle
- Authentification activée (elastic/kibana_system users)
- SSL/TLS activé entre tous les composants
- Certificats auto-générés pour développement

📚 Ressources
- [Documentation officielle Elastic](https://www.elastic.co/docs)
- [Tutoriel original](https://www.elastic.co/blog/getting-started-with-the-elastic-stack-and-docker-compose)
- [Repository GitHub officiel](https://github.com/elastic/stack-docker)
- [Docker Hub Elastic](https://www.docker.elastic.co/)

💡 Tip : Sauvegardez régulièrement vos configurations et dashboards via Stack Management > Saved Objects