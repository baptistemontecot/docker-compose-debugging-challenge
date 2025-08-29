#!/bin/bash
echo "Waiting for Kong to be fully ready..."
sleep 5

# Test de connectivité Kong Admin API
until curl -f http://kong:8001/status; do
  echo "Waiting for Kong Admin API..."
  sleep 2
done

echo "Configuring Kong services..."

# Configuration automatique des services
services=("user-service" "product-service" "order-service")
paths=("/api/users" "/api/products" "/api/orders")

for i in "${!services[@]}"; do
    service=${services[$i]}
    path=${paths[$i]}

    echo "Configuration de $service..."

    # Créer le service
    curl -s -X POST http://localhost:8001/services/ \
      --data "name=$service" \
      --data "url=http://$service:80"

    # Créer la route
    curl -s -X POST http://localhost:8001/services/$service/routes \
      --data "paths[]=$path"
done

echo "Configuration Kong terminée !"
