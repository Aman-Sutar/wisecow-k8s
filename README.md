

# Cow Wisdom Web Server (Wisecow)

## Overview
This repository contains the Wisecow application — a fun web server that combines the classic *fortune* and *cowsay* commands. This project containerizes the app and deploys it on a Kubernetes cluster with secure TLS communication and an automated CI/CD pipeline.

---


## Output

<img alt="image" src="https://github.com/user-attachments/assets/16c2a046-05d7-453a-8c3b-c7d3555a2830" />


---

## Problem Statement 1: Containerization and Kubernetes Deployment with TLS

### Requirements

1. Dockerize the Wisecow app.
2. Deploy on Kubernetes with manifests (Deployment, Service, Ingress).
3. Expose the app as a Kubernetes service.
4. Implement TLS to secure communication.
5. Setup a GitHub Actions CI/CD workflow to:

   * Build and push Docker image on code changes.


---

## Repository Structure

```
wisecow
├── Dockerfile
├── k8s/
│   ├── deployment.yaml
│   ├── service.yaml
│   ├── tls-ingress.yaml
│   ├── tls.crt        # TLS certificate (self-signed or generated)
│   ├── tls.key        # TLS private key
├── .github/
│   └── workflows/
│       └── docker-publish.yml     # GitHub Actions workflow
├── wisecow.sh         # Wisecow app script
├── README.md
```

---



---

## ⚙️ Kubernetes Prerequisite: Ingress Controller Setup (If Not PResent)

Before deploying the app, ensure the **NGINX Ingress Controller** is installed in your Kubernetes cluster.

> This is **mandatory** for the TLS and domain-based routing to work (`https://wisecow.local`).

### ✅ Install Ingress Controller (only once per cluster):

```bash
kubectl create namespace ingress-nginx

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.9.4/deploy/static/provider/cloud/deploy.yaml
```

## How to Build and Run Locally (Docker)

1. Clone Repo:

   ```bash
   git clone https://github.com/dodelaw332/wisecow-k8s.git
   cd wisecow-k8s
   ```

1. Build Docker image:

   ```bash
   docker build -t boxone123/wisecow:latest .
   ```

2. Run container locally (optional for testing):

   ```bash
   docker run -p 4499:4499 boxone123/wisecow:latest
   ```

3. Access the app at:

   ```
   http://localhost:4499
   ```

---

## How to Deploy on Kubernetes

1. Make sure you have a Kubernetes cluster running (Minikube, Kind, Docker Desktop Kubernetes, etc.)

2. Create the TLS secret (using your own cert and key files):

   ```bash
   kubectl create secret tls wisecow-tls --cert=k8s/tls.crt --key=k8s/tls.key
   ```

3. Apply Kubernetes manifests:

   ```bash
   kubectl apply -f k8s/deployment.yaml
   kubectl apply -f k8s/service.yaml
   kubectl apply -f k8s/tls-ingress.yaml
   ```

4. Add the following entry to your local `/etc/hosts` file to access the app using the TLS hostname:

   ```
   127.0.0.1 wisecow.local
   ```

5. Access the app securely at:

   ```
   https://wisecow.local
   ```

---

## Notes on TLS

* TLS certificates included are self-signed and intended for local testing.
* For production, replace with certificates from a trusted CA or use cert-manager in Kubernetes.

---

## CI/CD Pipeline (GitHub Actions)

* The workflow `/.github/workflows/docker-publish.yml`:

  * Builds and pushes Docker image on every push to the repo.
 
---

## Testing Instructions

To test the deployment and functionality:

1. Clone the repo.
2. Build and push Docker image or pull the existing one from Docker Hub.
3. Set up Kubernetes cluster (Minikube/Kind/Docker Desktop).
4. Create TLS secret as per instructions.
5. Deploy manifests with `kubectl apply`.
6. Update `/etc/hosts` with `wisecow.local` pointing to the cluster IP (usually localhost for local clusters).
7. Access `https://wisecow.local` in the browser to verify the app works with TLS.
8. Optionally, review GitHub Actions workflow runs to confirm Docker images are built and pushed.

---

## Troubleshooting

* If you get 404 errors, verify the ingress paths and service ports.
* Ensure TLS secret matches the hostname in ingress.
* For local Kubernetes, check that ingress controller is installed and running.
* Use `kubectl get pods,svc,ingress` to check resource statuses.

---

## License

This project is provided as-is for assessment purposes.

---

## Author

Aman-Sutar

---

*Thank you for reviewing my submission!*

```
