# Terraform Infrastructure Deployment Documentation

> This document provides detailed instructions for deploying infrastructure using Terraform. I have created four modules in this project: `ec2`, `eks`, and `vpc`. The goal is to create an environment that includes an EC2 instance for Jenkins, an EKS cluster with worker nodes, and a network infrastructure with subnets and NAT gateways.


## Modules Overview

### [EC2 Module]

The EC2 module creates an EC2 instance to host Jenkins.

### [EKS Module]

The EKS module creates an Amazon Elastic Kubernetes Service (EKS) cluster with worker nodes.

### [VPC Module]

The VPC module creates a network infrastructure such as subnets, NAT, IGW, and Route Table .

## Usage

1. Clone the repository:
```
git clone https://github.com/ahmedalaa14/Complete-CI-CD.git
```
2. Initialize Terraform:
```
terraform init
```
5. Deploy the infrastructure:
```
terraform apply
```
5. Destroy the infrastructure (when done):
```
terraform destroy