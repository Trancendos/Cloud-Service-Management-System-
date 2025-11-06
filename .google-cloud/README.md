# Google Cloud Build Configuration

This directory contains Google Cloud Build configuration for the Cloud Service Management System.

## Overview

The `cloudbuild.yaml` file provides equivalent functionality to the GitHub Actions workflow, including:
- Automated builds
- Dependency caching
- Node.js 20.x environment
- Build and test steps

## Setup Instructions

### 1. Prerequisites
- A Google Cloud Platform (GCP) project
- Cloud Build API enabled
- Repository connected to Cloud Build (GitHub, Cloud Source Repositories, Bitbucket)

### 2. Enable Cloud Build API

```bash
gcloud services enable cloudbuild.googleapis.com
```

### 3. Connect Repository

#### For GitHub Repositories:
1. Go to [Cloud Build Triggers](https://console.cloud.google.com/cloud-build/triggers)
2. Click **Connect Repository**
3. Select **GitHub** and authenticate
4. Choose your repository

#### For Cloud Source Repositories:
```bash
gcloud source repos create cloud-service-management
gcloud source repos clone cloud-service-management
```

### 4. Create Build Trigger

#### Using Console:
1. Navigate to **Cloud Build** → **Triggers**
2. Click **Create Trigger**
3. Configure:
   - **Name**: `cloud-service-ci`
   - **Event**: Push to branch
   - **Branch**: `^main$`
   - **Build configuration**: Cloud Build configuration file
   - **Location**: `.google-cloud/cloudbuild.yaml`
4. Click **Create**

#### Using gcloud CLI:
```bash
gcloud builds triggers create github \
  --name="cloud-service-ci" \
  --repo-name="Cloud-Service-Management-System-" \
  --repo-owner="YOUR-GITHUB-USERNAME" \
  --branch-pattern="^main$" \
  --build-config=".google-cloud/cloudbuild.yaml"
```

### 5. Create Pull Request Trigger

```bash
gcloud builds triggers create github \
  --name="cloud-service-pr-check" \
  --repo-name="Cloud-Service-Management-System-" \
  --repo-owner="YOUR-GITHUB-USERNAME" \
  --pull-request-pattern="^main$" \
  --build-config=".google-cloud/cloudbuild.yaml"
```

## Key Features

### Caching
Cloud Build provides automatic caching for build artifacts:
```yaml
cache:
  paths:
    - '/workspace/.npm-cache'
    - '/workspace/node_modules'
```

### Node.js Container
Uses official Node.js 20 Docker image:
```yaml
- name: 'node:20'
  entrypoint: 'npm'
  args: ['install']
```

### Build Steps
Each step runs in the Node.js container:
```yaml
- name: 'node:20'
  id: 'build'
  entrypoint: 'bash'
  args:
    - '-c'
    - |
      echo "Build completed"
```

## Customization

### Adding npm Build Scripts
```yaml
- name: 'node:20'
  id: 'build-app'
  entrypoint: 'npm'
  args: ['run', 'build']
```

### Adding Tests
```yaml
- name: 'node:20'
  id: 'run-tests'
  entrypoint: 'npm'
  args: ['test']
```

### Using Different Node.js Version
Change the Docker image version:
```yaml
- name: 'node:18'  # or node:16, node:22, etc.
```

### Environment Variables
Add environment variables to steps:
```yaml
- name: 'node:20'
  env:
    - 'NODE_ENV=production'
    - 'API_KEY=${_API_KEY}'
```

Then define substitution variables in the trigger:
```bash
gcloud builds triggers update TRIGGER_NAME \
  --substitutions=_API_KEY="your-api-key"
```

## Machine Types

Adjust compute resources by changing the machine type:
```yaml
options:
  machineType: 'N1_HIGHCPU_8'  # 8 vCPU
  # Other options: E2_HIGHCPU_8, N1_HIGHCPU_32, etc.
```

## Manual Builds

### Using gcloud CLI
```bash
gcloud builds submit --config=.google-cloud/cloudbuild.yaml
```

### With Substitutions
```bash
gcloud builds submit \
  --config=.google-cloud/cloudbuild.yaml \
  --substitutions=_NODE_ENV="production"
```

## Best Practices

1. **Use Specific Image Tags**: Instead of `node:20`, use `node:20.11.0` for reproducibility
2. **Leverage Caching**: Cache dependencies to speed up builds
3. **Optimize Docker Images**: Use multi-stage builds for smaller images
4. **Set Timeouts**: Configure appropriate timeout values (default: 10 minutes)
5. **Monitor Builds**: Use Cloud Logging to track build performance
6. **Secure Secrets**: Use Secret Manager for sensitive data

## Secrets Management

### Using Secret Manager
```yaml
availableSecrets:
  secretManager:
    - versionName: projects/PROJECT_ID/secrets/npm-token/versions/latest
      env: 'NPM_TOKEN'

steps:
  - name: 'node:20'
    entrypoint: 'bash'
    args:
      - '-c'
      - |
        echo "//registry.npmjs.org/:_authToken=${NPM_TOKEN}" > .npmrc
    secretEnv: ['NPM_TOKEN']
```

## Troubleshooting

### Build Fails to Start
- Verify Cloud Build API is enabled
- Check service account permissions
- Ensure the trigger is properly configured

### Cache Not Working
- Verify cache paths are correct
- Check available disk space
- Review build logs for cache restoration messages

### Permission Errors
- Grant Cloud Build service account necessary IAM roles:
  ```bash
  gcloud projects add-iam-policy-binding PROJECT_ID \
    --member=serviceAccount:PROJECT_NUMBER@cloudbuild.gserviceaccount.com \
    --role=roles/storage.admin
  ```

### Timeout Issues
Increase timeout in configuration:
```yaml
timeout: '1200s'  # 20 minutes
```

## Resources

- [Cloud Build Documentation](https://cloud.google.com/build/docs)
- [Build Configuration Overview](https://cloud.google.com/build/docs/build-config-file-schema)
- [Cloud Build Triggers](https://cloud.google.com/build/docs/triggers)
- [Cloud Build Pricing](https://cloud.google.com/build/pricing)
