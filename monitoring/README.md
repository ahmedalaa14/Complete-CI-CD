# Prometheus and Grafana Deployment

This project contains the Kubernetes manifests for deploying Prometheus and Grafana.

# Architecture 

- Architecture Prometheus - Grafana:

![Architecture Prometheus - Grafana](images/Architecture-Prometheus-Grafana.png)

## Prerequisites

- Kubernetes cluster (e.g., minikube, GKE, EKS)
- kubectl installed and configured

## Deployment

To deploy Prometheus and Grafana, follow these steps:

1. Clone this repository:

```bash
git clone https://github.com/ahmedalaa14/Complete-CI-CD.git
cd monitoring
```

2. Apply the Kubernetes manifests:
```bash
kubectl apply -f prometheus.yaml
kubectl apply -f grafana.yaml
```

## Accessing the Services
- After deployment, you can access the services as follows:

Prometheus: Run 
```bash 
minikube service prometheus-service -n library
``` 
to get the URL for Prometheus.
Grafana: 
Run 
```bash 
minikube service grafana-service -n library 
``` 
to get the URL for Grafana.
