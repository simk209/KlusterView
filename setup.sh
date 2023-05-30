#!/bin/bash

#Setting context
current_dir=$(pwd)
echo "current_dir is $current_dir"
parentdir="$(dirname "$current_dir")"
echo $parentdir

echo "Setting up Prometheus..."
#Delete namespace if it exists
kubectl delete namespace monitoring --ignore-not-found

kubectl create namespace monitoring
kubectl apply -f $current_dir/deployment/clusterRole.yaml
kubectl apply -f $current_dir/deployment/config-map.yaml
kubectl apply  -f $current_dir/deployment/prometheus-deployment.yaml 
kubectl apply -f $current_dir/deployment/prometheus-service.yaml --namespace=monitoring

#kubectl get deployments --namespace=monitoring
#kubectl get pods --namespace=monitoring

echo "Setting up Grafana..."
kubectl create -f $current_dir/deployment/grafana-datasource-config.yaml
kubectl create -f $current_dir/deployment/deployment.yaml
kubectl create -f $current_dir/deployment/service.yaml




