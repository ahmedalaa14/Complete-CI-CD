# Kubernetes Deployment

- This project contains Kubernetes manifests for deploying our application. The manifests are located in the `kubernetes/` directory and include resources such as Deployment, Service, Ingress , presistent-volume and persistent-volume-claim.

## Prerequisites

- **Kubernetes Cluster**: Ensure you have access to a Kubernetes cluster.
- **kubectl**: Install `kubectl` to interact with the Kubernetes cluster. Follow the [official guide](https://kubernetes.io/docs/tasks/tools/install-kubectl/) for installation instructions.

## Directory Structure

- The `kubernetes/` directory contains the following YAML files:

```plaintext
kubernetes/
├── deployment.yaml              # Deployment configuration for the application
├── service.yaml                 # Service definition to expose the application
├── ingress.yaml                 # Ingress rules for routing external traffic to the application
├── persistent-volume.yaml       # Persistent Volume configuration for data storage
└── persistent-volume-claim.yaml # Persistent Volume Claim to request storage from the Persistent Volume
```

## Applying the Manifests

- To apply all the Kubernetes manifests in the `kubernetes/` directory, run the following command:

```bash
kubectl apply -f kubernetes/
```
- This command will create the Kubernetes resources defined in the manifests, including the Deployment, Service, Ingress, Persistent Volume, and Persistent Volume Claim.

## Applying Kubernetes Files.

![Applying Kubernetes Files](<images/Applying Kubernetes Files.png>)