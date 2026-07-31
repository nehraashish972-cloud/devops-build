# DevOps Build — Application Deployment Project

## Overview
This project deploys a React application to a production-ready environment using Docker, Jenkins CI/CD, AWS EC2, and open-source monitoring.

## Live Links
- **Deployed Site:** http://3.108.59.225
- **GitHub Repo:** https://github.com/nehraashish972-cloud/devops-build
- **Docker Hub Images:**
  - Dev (public): `asheesh972/devops-build-dev:latest`
  - Prod (private): `asheesh972/devops-build-prod:latest`

## Tech Stack
- React (production build)
- Docker & Docker Compose
- Jenkins (Multibranch Pipeline, running in Docker)
- AWS EC2 (t2.micro, Ubuntu 22.04)
- Uptime Kuma (open-source monitoring)

## Project Structure
- `Dockerfile` — builds an nginx image serving the React `build/` folder on port 80
- `docker-compose.yml` — runs the app container
- `build.sh` — builds the Docker image
- `deploy.sh` — pulls and deploys the image to the server
- `Jenkinsfile` — CI/CD pipeline: checkout → build → push → deploy

## CI/CD Flow
- Push to `dev` branch → image built & pushed to `devops-build-dev` (Docker Hub)
- Merge `dev` → `main` → image built & pushed to `devops-build-prod` (Docker Hub)
- Both triggers auto-run via GitHub webhook connected to Jenkins

## AWS Security Group Rules
- Port 22 (SSH): restricted to admin IP only
- Port 80 (HTTP): open to all (public app access)
- Port 8080 (Jenkins): open (CI/CD + webhook)
- Port 3001 (Monitoring): restricted to admin IP only

## Monitoring
Uptime Kuma checks the deployed site every 60 seconds and sends a notification only if the site goes down.

## How to Run Locally
\`\`\`bash
docker build -t devops-build:local .
docker run -d -p 8080:80 devops-build:local
\`\`\`
Visit http://localhost:8080

## Screenshots
See the `/screenshots` folder for:
- Jenkins (login, configuration, console output)
- AWS EC2 console & Security Group
- Docker Hub repos with image tags
- Deployed site page
- Monitoring health check status

## Note
This project was deployed for evaluation purposes. AWS resources may be terminated after submission to avoid ongoing costs. Docker images remain available on Docker Hub as proof of build.
