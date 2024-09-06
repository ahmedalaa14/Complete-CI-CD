# Banque Misr Graduation Project.
  
## Project Overview
- The Library Management System is a robust application developed using Flask. It provides a comprehensive solution for managing a library's catalogue. The system allows users to add new books to the library, view a list of all available books, borrow a book, search for a specific book, and return a borrowed book. With its user-friendly interface and efficient search capabilities, it streamlines the process of library management and enhances the user experience.

## Technologies
- **Flask**: A lightweight WSGI web application framework used to implement the application.
- **Docker**: Used for creating, deploying, and running the application using containerization.
- **Kubernetes**: Used to automate deploying, scaling, and managing containerized applications.
- **Ansible**: Configuration management, and application-deployment tool.
- **Bash**:  Used for Automate the deployment of Dockerfile.
- **AWS**: Amazon Web Services is used for on-demand cloud computing platforms and APIs.
- **Terraform**: Infrastructure as code software tool that provides a consistent CLI workflow to manage hundreds of cloud services.
- **Jenkins**: Automate the parts of software development related to building, testing, and deploying, facilitating CI - CD.
- **Prometheus**: Monitoring and alerting toolkit.
- **Grafana**: It allows you to query, visualize, alert on, and understand your metrics no matter where they are stored.

## Installation
1. **Clone the repository**:

   ```bash
   git clone https://github.com/ahmedalaa14/Complete-CI-CD
   cd Complete-CI-CD
   ```

2. **Install Python dependencies**:

   ```bash
   pip install -r requirements.txt
   ```

## Usage

### Running the Application Locally

To run the application on your local machine:

1. **Start the Flask application**:

   ```bash
   python app.py
   ```

2. **Access the application**:

   Open your browser and navigate to `http://localhost:5000`.

## Docker
- Used to containerize the application

1. **Build the Docker image**:

   ```bash
   docker build -t ahmedalaa14/flask-app-mini .
   ```

2. **Run the Docker container**:

   ```bash
   docker run -d --name python-app -p 5000:5000 ahmedalaa14/flask-app-mini
   ```
3. **Push Docker Image to DockerHub**

   ```bash
   docker push ahmedalaa14/flask-app-mini
   ```

4. **Access the application**:

   Open your browser and navigate to `http://localhost:5000`.

## Bouns In Docker 
- we created a multi-stage dockerfile contains build stage and production stage.
- the benefits of that are Smaller Image Size, Faster Deployments, Improved Security and Better Caching.

![Docker Image Before Multi Stage Dockerfile](<images/dockerImage- before multistage.png>)
![Docker Image After Multi Stage Dockerfile](<images/dockerImage- minimize.png>)

## Ansible
- created `playbook.yml` to automate the workflow of building, tagging, pushing Docker images to DockerHub, and deploying a container from the image.
```yaml
---
- name: "Automate Docker Build using Ansible"
  hosts: localhost
  tasks:
  - name: stop running container 
    command: docker stop python-app
    ignore_errors: true

  - name: remove stopped container 
    command: docker rm python-app
    ignore_errors: true


  - name: remove used image 
    command: docker rmi ahmedalaa14/flask-app-mini
    ignore_errors: true

  - name: build new image 
    command: docker build -t ahmedalaa14/flask-app-mini .

  - name: push docker image  
    command: docker push ahmedalaa14/flask-app-mini


  - name: run new container
    command: docker run -d --name python-app -p 5000:5000 ahmedalaa14/flask-app-mini
```    

## Bash Script
- Same as the Ansible `playbook.yml` to automate the workflow of building, tagging, pushing Docker images to DockerHub, and deploying a container from the image.

```yaml
#!/bin/bash

# Stop running container
docker stop python-app || true

# Remove stopped container
docker rm python-app || true

# Remove used image
docker rmi ahmedalaa14/flask-app-mini || true

# Build new image
docker build -t ahmedalaa14/flask-app-mini .

# Push docker image
docker push ahmedalaa14/flask-app-mini

# Run new container
docker run -d --name python-app -p 5000:5000 ahmedalaa14/flask-app-mini
```
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


# Terraform Infrastructure Deployment 

- This document provides detailed instructions for deploying infrastructure using Terraform. I have created Three modules in this project: `ec2`, `eks`, and `vpc`. The goal is to create an environment that includes an EC2 instance for Jenkins, an EKS cluster with worker nodes, and a network infrastructure with subnets and NAT gateways.


## Modules Overview

### EC2 Module

- The EC2 module creates an EC2 instance to host Jenkins.

### EKS Module

- The EKS module creates an Amazon Elastic Kubernetes Service (EKS) cluster with worker nodes.

### VPC Module

- The VPC module creates a network infrastructure such as subnets, NAT, IGW, and Route Table.
## Usage

1. Clone the repository:
```
git clone https://github.com/ahmedalaa14/Complete-CI-CD.git
```
2. Initialize Terraform:
```
terraform init
```
3. Deploy the infrastructure:
```
terraform apply
```
4. Destroy the infrastructure (when done):
```
terraform destroy
```

[Infrastructure-Deployment Using Terraform](<images/Infrastructure-Deployment Using Terraform.png>)
