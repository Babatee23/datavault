# Deployment Guide

## Overview

This project implements an end-to-end Platform Engineering and GitOps workflow using:

* Terraform
* AWS EC2
* AWS ECR
* Docker
* K3s
* Kubernetes
* ArgoCD
* GitHub Actions

---

## Architecture

```text
Developer
     ↓
GitHub Repository
     ↓
GitHub Actions
     ↓
Build Docker Image
     ↓
Push Docker Image to AWS ECR
     ↓
ArgoCD monitors Git repository
     ↓
ArgoCD syncs K3s cluster
     ↓
Application Deployment
```

---

## Infrastructure Provisioning

Terraform was used to provision:

* EC2 instance
* Security Group
* ECR repository
* SSH key configuration

Commands:

```bash
terraform init
terraform plan
terraform apply
terraform destroy
```

---

## Docker Containerization

Build Docker image:

```bash
docker build -t datavault-api:v1 .
```

Tag image:

```bash
docker tag datavault-api:v1 <account-id>.dkr.ecr.us-east-1.amazonaws.com/k3s-platform-repo:v1
```

Push image:

```bash
docker push <account-id>.dkr.ecr.us-east-1.amazonaws.com/k3s-platform-repo:v1
```

---

## K3s Installation

SSH into EC2:

```bash
ssh -i "/c/K3.pem" ubuntu@<EC2-PUBLIC-IP>
```

Install K3s:

```bash
curl -sfL https://get.k3s.io | sh -
```

Verify node:

```bash
kubectl get nodes
```

---

## Kubernetes Resources

Implemented resources:

* Deployment
* Service
* ConfigMap
* Secret
* Horizontal Pod Autoscaler (HPA)

Deploy resources:

```bash
kubectl apply -f k8s/
```

Verify:

```bash
kubectl get pods
kubectl get svc
kubectl get deployments
kubectl get hpa
```

---

## ArgoCD Installation

Create namespace:

```bash
kubectl create namespace argocd
```

Install ArgoCD:

```bash
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

Expose UI:

```bash
kubectl patch svc argocd-server -n argocd -p '{"spec":{"type":"NodePort"}}'
```

Get password:

```bash
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```

---

## GitHub Actions CI/CD

Workflow path:

```text
.github/workflows/ci.yml
```

Pipeline stages:

1. Checkout repository
2. Configure AWS credentials
3. Authenticate to ECR
4. Build Docker image
5. Push image to ECR

---

## GitOps Workflow

```text
Developer pushes code
        ↓
GitHub Actions runs
        ↓
Docker image pushed to ECR
        ↓
ArgoCD detects repository changes
        ↓
K3s cluster synchronizes automatically
        ↓
Application deployment updated
```

---

## Deliverables

* Terraform deployment evidence
* EC2 instance running
* Docker image build
* ECR image repository
* K3s node verification
* Kubernetes pod deployment
* ArgoCD dashboard
* ArgoCD synced application
* GitHub Actions successful workflow

```
```
