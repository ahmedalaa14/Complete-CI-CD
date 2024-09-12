# Banque Misr Final Project.
  
## Project Overview
- The Library Management System is an application developed using Python and Flask, designed to streamline the management of a library's catalogue. The system allows users to add, view, search, borrow, and return books with ease. A key feature of this project is its robust DevOps pipeline, which supports continuous integration, continuous deployment, infrastructure automation, monitoring, and alerting, ensuring seamless updates and efficient operations across environments.

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
   cd app
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

- It Should be like That.
  
![Python App Deployment Local](<images/Python App Deployment Local.png>)   

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
  
- Docker Image Before Multi Stage Dockerfile
  
![Docker Image Before Multi Stage Dockerfile](<images/dockerImage- before multistage.png>)

- Docker Image After Multi Stage Dockerfile

![Docker Image After Multi Stage Dockerfile](<images/dockerImage- minimize.png>)

## Ansible (Bonus)
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

## Bash Script (Bonus)
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

- Applying Kubernetes Files.

![Applying Kubernetes Files](<images/Applying Kubernetes Files.png>)

# Terraform Infrastructure Deployment 

- This document provides detailed instructions for deploying infrastructure using Terraform. I have created Three modules in this project: `ec2`, `eks`, and `vpc`. The goal is to create an environment that includes an EC2 instance for Jenkins, an EKS cluster with worker nodes, and a network infrastructure with subnets and NAT gateways.


## Modules Overview (Bonus)

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
cd terraform
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
- Infrastructure-Deployment Using Terraform
![Infrastructure-Deployment Using Terraform](<images/Infrastructure-Deployment Using Terraform.png>)

- App Deployment on EKS.
  
![App Deplyment on Eks](<images/App Deplyment on Eks.png>)

# Jenkins EC2 Instance Setup with Ansible (Bonus)

- This project automates the setup of Jenkins and several DevOps tools on an EC2 instance using Ansible. The setup includes Docker, AWS CLI, Kubernetes, Terraform, Trivy, and Jenkins, with role-based permission configuration.



- The Ansible playbook automates the following tasks:

- **Installing and configuring Jenkins** on an EC2 instance.
- **Installing Docker** and enabling it to manage containers.
- **Installing AWS CLI** for cloud operations.
- **Installing Kubernetes tools (kubectl)** for managing K8s clusters.
- **Installing Terraform** for infrastructure as code.
- **Installing Trivy** for container image scanning.
- **Configuring permissions** for Jenkins and other tools.

## Prerequisites

- Before running the playbook, ensure the following are in place:

- Ansible is installed on the control machine.
- SSH access to the target EC2 instance is set up (the `jenkins-ec2` host group should be defined in your Ansible inventory).
- AWS credentials are available if AWS CLI operations are required.
- EC2 instance should have sufficient permissions for installing software.

## How to Use

### Clone the Repository

```bash
git clone https://github.com/ahmedalaa14/Comlete-CI-CD.git
cd ansible
```

# Jenkins EC2 Provisioning

## Update the Inventory

- To provision an EC2 instance with Jenkins, you'll need to update your inventory file to include the EC2 instance under the `jenkins-ec2` host group. Modify your inventory file as follows:

```bash
[jenkins-ec2]
ec2-instance-ip ansible_user=ubuntu ansible_ssh_private_key_file=path-to-your-key.pem
Replace ec2-instance-ip with the actual IP address of your EC2 instance, and path-to-your-key.pem with the path to your SSH private key file.
```
## Run the Playbook
- After updating the inventory file, run the Ansible playbook to provision the EC2 instance with Jenkins and related tools:


```bash
ansible-playbook -i inventory playbook.yml
This command will execute the playbook defined in palybook.yml and set up Jenkins on the EC2 instance.
```

## Access Jenkins
- Once the playbook has completed, you can access Jenkins by navigating to the following URL in your web browser:

```bash
http://<EC2-instance-IP>:8080
Replace <EC2-instance-IP> with the actual IP address of your EC2 instance.
```
- Deployment Jenkins on EC2 Using Ansible
  
![Jenkins-on-EC2-Deployment](<images/Jenkins-on-EC2-Deployment.png>)


# Monitoring (Bonus)

- Prometheus and Grafana Deployment.

# Architecture 

- Architecture Prometheus - Grafana:
![Architecture Prometheus - Grafana](https://github.com/ahmedalaa14/Complete-CI-CD---DevOps/blob/main/images/Architecture%20Prometheus%20-%20Grafana.png)

## Prerequisites

- Kubernetes cluster (e.g., minikube, GKE, EKS).
- kubectl installed and configured.

## Deployment

- To deploy Prometheus and Grafana, follow these steps:

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
- to get the URL for Prometheus.
Grafana: 
Run 
```bash 
minikube service grafana-service -n library 
``` 
- to get the URL for Grafana.

```bash
aws eks update-cluster-config --region eu-north-1 --name team6-cluster
```

- Prometheus Deployment.

![Promerhus Deployment](https://github.com/ahmedalaa14/Complete-CI-CD---DevOps/blob/main/images/Promethus%20Deployment.png)

- Grafana Dashboard.

![Grafana Dashboard](https://github.com/ahmedalaa14/Complete-CI-CD---DevOps/blob/main/images/Grafana%20Dashboard.png)


## Jenkins Pipeline 

- General Architecture :

![General Architecture](https://github.com/ahmedalaa14/Complete-CI-CD/blob/main/images/general_arch.png)

- Jenkins Pipeline Architecture :

![CI Architecture](https://github.com/ahmedalaa14/Complete-CI-CD/blob/main/images/CI_ARCH.png)

# CI Stages 
- This Jenkins pipeline automates the build, testing, security scanning, and deployment process for a Flask application. It includes several stages for ensuring code quality and security compliance, leveraging tools like SonarQube, OWASP Dependency Check, Trivy, Grype, and Terrascan.

## Key Features

- **Python Virtual Environment Setup**: Isolates dependencies using Python's `venv`.
- **Dependency Installation**: Installs required packages such as Flask and pytest.
- **Testing**: Runs unit tests and generates reports, including test coverage.
- **Code Quality Analysis**: Performs static analysis using SonarQube.
- **Security Scans**:
  - **OWASP Dependency Check**: Scans for vulnerabilities in dependencies.
  - **Docker Image Scanning**: Scans Docker images for vulnerabilities using Trivy and Grype.
  - **Infrastructure Scanning**: Scans Terraform code for compliance using Terrascan.
- **Docker Image Build**: Builds and tags a Docker image for the Flask application.
- **Sending Notification to Slack**: Utilizes Slack notifications for real-time updates on the CI/CD pipeline status after each Jenkins job, indicating success or failure.

# Continous Integration Pipeline 

![Complete Continuous Integration Diagram](https://github.com/ahmedalaa14/Complete-CI-CD---DevOps/blob/main/images/Complete%20Continous%20Integration.png)

# SonarQube Analysis Integration

![SonarQube Analysis Integration](https://github.com/ahmedalaa14/Complete-CI-CD---DevOps/blob/main/images/SonarQube%20Analysis.png)

- SonarQube Issues That Developers Should Fix.

![SonarQube Issues](https://github.com/ahmedalaa14/Complete-CI-CD---DevOps/blob/main/images/The%20Issues%20In%20SonarQube-%20UI.png)

# Trivy Scan For Docker Image

- Trivy is a simple and comprehensive vulnerability scanner for Docker images. It's capable of detecting vulnerabilities of OS packages (Alpine, RHEL, CentOS, etc.) and application dependencies (Bundler, Composer, npm, yarn, etc.).


![Trivy Scan](https://github.com/ahmedalaa14/Complete-CI-CD---DevOps/blob/main/images/Trivy%20Scan.png)

# Grype Scan For Docker Image

- Grype is a vulnerability scanner for Docker images. It scans the packages within the Docker image and checks them against a database of known vulnerabilities.
 

![Grype Scan](https://github.com/ahmedalaa14/Complete-CI-CD---DevOps/blob/main/images/Grype%20Scan.png)

## Terrascan for Terraform Code

- Terrascan Summary: Terrascan is a comprehensive tool used for scanning Infrastructure as Code (IaC) for security vulnerabilities and compliance issues. Detailed results of each Terrascan scan are stored in the `terrascan.txt` file.

![TerraScan](https://github.com/ahmedalaa14/Complete-CI-CD---DevOps/blob/main/images/Terrascan%20.png)

## CD Stages

- the stages of the Continuous Deployment (CD) pipeline used for deploying Docker images and managing infrastructure with Terraform and Deploy Kubernetes Files and Monitoring Files to EKS.

## Key Stages

- **Push Docker Image to DockerHub**:  Authenticates and pushes Docker images to DockerHub with a build-specific tag.

- **Deploy Infrastructure**: Initializes and applies Terraform configurations to deploy the infrastructure.

- **Update Kubeconfig**:  Updates the kubeconfig file to interact with the EKS cluster.

- **Deploy Kubernetes Files to EKS**: Creates the necessary Kubernetes namespace and applies configuration files to deploy the application.

- **Deploy Monitoring Grafana and Prometheus to EKS**:  Deploys monitoring tools such as Grafana and Prometheus to the EKS cluster.

## Continous Deployment Pipeline 

![CD-Stages](https://github.com/ahmedalaa14/Complete-CI-CD---DevOps/blob/main/images/CD%20-%20Stages.png)

## DockerHub After Pipeline

![DockerHub](https://github.com/ahmedalaa14/Complete-CI-CD---DevOps/blob/main/images/Docker%20Push%20to%20DockerHub.png)


# Deploy App to Eks

![App on Eks](https://github.com/ahmedalaa14/Complete-CI-CD---DevOps/blob/main/images/Application%20on%20Eks.png)

# Prometheus Deployment to EKS

![Prometheus on Eks](https://github.com/ahmedalaa14/Complete-CI-CD---DevOps/blob/main/images/Promethues%20EKS.png)

## Grafana on EKS

![Grafana On Eks](https://github.com/ahmedalaa14/Complete-CI-CD---DevOps/blob/main/images/Garafana%20on%20EKS.png)

![Grafana Eks](https://github.com/ahmedalaa14/Complete-CI-CD---DevOps/blob/main/images/Geafana%20Eks.png)

## Slack Notification after CI - CD Pipeline

> A notification is sent to a designated Slack channel at the end of each job, indicating whether the job was successful or failed. This immediate feedback allows the team to quickly identify and address any issues, enhancing the efficiency and reliability of our development process.


![Slack Notification](https://github.com/ahmedalaa14/Complete-CI-CD---DevOps/blob/main/images/Slack%20Notification.png)
