#!/bin/bash

echo "Check helm is intall or not"
helm version

echo "Creating namespace for monitoring"
kubectl create namespace monitoring

echo "Adding prometheus repo"
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

echo "After adding repo updating repo"
helm repo update

echo "Install prometheus stack and set prometheus & grafana type NodePort  "
helm install prometheus-stack prometheus-community/kube-prometheus-stack --namespace monitoring --set prometheus.service.nodePort=30000 --set grafana.service.nodePort=31000 --set grafana.service.type=NodePort --set prometheus.service.type=NodePort

echo "Get service and do kubectl port for prometheus & grafana"
kubectl get svc -n monitoring
