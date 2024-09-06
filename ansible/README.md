# Jenkins EC2 Instance Setup with Ansible

This project automates the setup of Jenkins and several DevOps tools on an EC2 instance using Ansible. The setup includes Docker, AWS CLI, Kubernetes, Terraform, Trivy, and Jenkins, with role-based permission configuration.

## Project Overview

The Ansible playbook automates the following tasks:

- **Installing and configuring Jenkins** on an EC2 instance.
- **Installing Docker** and enabling it to manage containers.
- **Installing AWS CLI** for cloud operations.
- **Installing Kubernetes tools (kubectl)** for managing K8s clusters.
- **Installing Terraform** for infrastructure as code.
- **Installing Trivy** for container image scanning.
- **Configuring permissions** for Jenkins and other tools.

Roles are modular and reusable, making the setup scalable and adaptable to different environments.

## Roles

This playbook utilizes the following Ansible roles:

### 1. Common

- **Purpose**: Ensures the EC2 instance is updated and all necessary system utilities are installed.
- **Tasks**:
  - Updating package repositories.
  - Installing common utilities like unzip, wget, etc.

### 2. Docker

- **Purpose**: Installs Docker and ensures the Docker service is running.
- **Tasks**:
  - Installing Docker CE.
  - Enabling and starting the Docker service.
  - Adding the Jenkins user to the Docker group to allow Jenkins to manage containers.

### 3. AWS CLI

- **Purpose**: Installs and configures AWS CLI for cloud resource management.
- **Tasks**:
  - Installing AWS CLI version 2.
  - Configuring access credentials (optional, based on environment variables).

### 4. Kubernetes

- **Purpose**: Installs kubectl for managing Kubernetes clusters.
- **Tasks**:
  - Downloading and installing the kubectl binary.
  - Configuring Kubernetes contexts (optional).

### 5. Terraform

- **Purpose**: Installs Terraform for managing infrastructure as code.
- **Tasks**:
  - Installing Terraform.
  - Configuring the environment for Terraform use (optional).

### 6. Trivy

- **Purpose**: Installs Trivy for container image scanning.
- **Tasks**:
  - Installing Trivy.
  - Running initial container image scans (optional).

### 7. Jenkins

- **Purpose**: Installs Jenkins and sets it up for use in a CI/CD pipeline.
- **Tasks**:
  - Installing Jenkins.
  - Configuring Jenkins to run on a specific port.
  - Setting up initial Jenkins plugins and user configuration.
  - Managing the Jenkins service.

### 8. Permissions

- **Purpose**: Configures permissions for Jenkins and other tools for seamless integration.
- **Tasks**:
  - Adding Jenkins to required groups (e.g., Docker, Kubernetes, Terraform).
  - Ensuring proper file and directory permissions for all installed tools.

## Prerequisites

Before running the playbook, ensure the following are in place:

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

To provision an EC2 instance with Jenkins, you'll need to update your inventory file to include the EC2 instance under the `jenkins-ec2` host group. Modify your inventory file as follows:

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
