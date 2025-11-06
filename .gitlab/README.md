# GitLab CI/CD Configuration

This directory contains GitLab CI/CD pipeline configuration for the Cloud Service Management System.

## Overview

The `.gitlab-ci.yml` file provides equivalent functionality to the GitHub Actions workflow, including:
- Automated builds on push and merge requests
- Dependency caching
- Node.js 20 environment
- Multi-stage pipeline (build and test)

## Setup Instructions

### 1. Prerequisites
- A GitLab account (GitLab.com or self-hosted)
- Repository hosted on GitLab or mirrored from another source

### 2. Add Configuration

The `.gitlab-ci.yml` file should be placed in the root of your repository:
```bash
# If using a GitLab repository directly, copy the file:
cp .gitlab/.gitlab-ci.yml ./.gitlab-ci.yml

# If mirroring from GitHub:
# Set up repository mirroring in GitLab
```

### 3. Configure Repository Mirroring (Optional)

If your primary repository is on GitHub or another platform:

1. Navigate to **Settings** → **Repository** → **Mirroring repositories**
2. Enter the repository URL
3. Select **Mirror direction**: Pull
4. Add authentication credentials
5. Enable **Mirror only protected branches** or **Trigger pipelines for mirror updates**
6. Click **Mirror repository**

### 4. Enable CI/CD

1. Navigate to **Settings** → **CI/CD**
2. Ensure **Public pipelines** is enabled (if desired)
3. Configure **Auto DevOps** settings if needed

### 5. View Pipeline

- Go to **CI/CD** → **Pipelines** to view pipeline runs
- Click on a pipeline to see job details

## Key Features

### Pipeline Stages

The pipeline defines two stages:
```yaml
stages:
  - build
  - test
```

### Caching

GitLab CI caches npm dependencies based on `package-lock.json`:
```yaml
cache:
  key:
    files:
      - package-lock.json
  paths:
    - .npm/
    - node_modules/
```

### Docker Image

Uses official Node.js 20 Docker image:
```yaml
image: node:20
```

### Workflow Rules

Controls when pipelines run:
- Push to main branch
- Merge request events
- Manual triggers via web UI

```yaml
workflow:
  rules:
    - if: '$CI_PIPELINE_SOURCE == "push" && $CI_COMMIT_BRANCH == "main"'
    - if: '$CI_PIPELINE_SOURCE == "merge_request_event"'
    - if: '$CI_PIPELINE_SOURCE == "web"'
```

## Customization

### Adding Build Scripts

```yaml
build:
  stage: build
  script:
    - npm ci
    - npm run build
  artifacts:
    paths:
      - dist/
    expire_in: 1 hour
```

### Adding Tests

```yaml
test:
  stage: test
  dependencies:
    - build
  script:
    - npm test
  coverage: '/Lines\s*:\s*(\d+\.\d+)%/'
  artifacts:
    reports:
      coverage_report:
        coverage_format: cobertura
        path: coverage/cobertura-coverage.xml
```

### Using Different Node.js Versions

#### Single Version
```yaml
image: node:18  # or node:16, node:22, etc.
```

#### Multiple Versions (Matrix)
```yaml
build:
  image: node:${NODE_VERSION}
  parallel:
    matrix:
      - NODE_VERSION: ["18", "20", "22"]
  script:
    - npm ci
    - npm run build
```

### Environment Variables

#### In .gitlab-ci.yml:
```yaml
variables:
  NODE_ENV: "production"
  API_URL: "https://api.example.com"
```

#### In GitLab UI:
1. Navigate to **Settings** → **CI/CD** → **Variables**
2. Click **Add variable**
3. Enter key and value
4. Choose options:
   - **Protect variable**: Only available in protected branches
   - **Mask variable**: Hide value in job logs
   - **Expand variable reference**: Allow variable expansion

### Services (Docker in Docker, Databases)

```yaml
services:
  - postgres:14
  - redis:latest

variables:
  POSTGRES_DB: testdb
  POSTGRES_USER: testuser
  POSTGRES_PASSWORD: testpass
```

## Advanced Features

### Conditional Jobs

Run jobs based on conditions:
```yaml
deploy:
  stage: deploy
  script:
    - echo "Deploying..."
  only:
    - main
  except:
    - schedules
```

### Manual Jobs

Require manual trigger:
```yaml
deploy-production:
  stage: deploy
  script:
    - echo "Deploying to production..."
  when: manual
  only:
    - main
```

### Scheduled Pipelines

Create scheduled pipelines:
1. Navigate to **CI/CD** → **Schedules**
2. Click **New schedule**
3. Set interval (cron syntax)
4. Define target branch
5. Optionally set variables

### Artifacts

Store and share build outputs:
```yaml
build:
  artifacts:
    paths:
      - dist/
      - build/
    expire_in: 1 week
    reports:
      junit: test-results/*.xml
```

### Parallel Jobs

Run jobs in parallel:
```yaml
test:
  parallel: 3
  script:
    - npm run test -- --shard=$CI_NODE_INDEX/$CI_NODE_TOTAL
```

## GitLab Runners

### Shared Runners
GitLab.com provides shared runners with:
- Linux, Windows, and macOS
- Docker executor
- Free tier: 400 CI/CD minutes/month

### Self-Hosted Runners

Install GitLab Runner:
```bash
# Linux
sudo apt-get install gitlab-runner

# Register runner
sudo gitlab-runner register \
  --url https://gitlab.com/ \
  --registration-token YOUR_TOKEN \
  --executor docker \
  --docker-image node:20
```

## Best Practices

1. **Use Caching**: Cache dependencies to speed up builds
2. **Specify Image Tags**: Use specific versions (e.g., `node:20.11.0`)
3. **Limit Artifacts**: Set expiration times to save storage
4. **Use Workflow Rules**: Control pipeline execution efficiently
5. **Secure Variables**: Mark sensitive variables as protected and masked
6. **Organize Stages**: Group related jobs into logical stages
7. **Monitor Usage**: Track CI/CD minutes and optimize jobs

## Monitoring & Debugging

### View Logs
- Click on job in pipeline view
- Real-time logs during execution
- Full logs available after completion

### Debug Locally

Use GitLab Runner locally:
```bash
gitlab-runner exec docker build
```

### Enable Debug Logging
Add variable to job:
```yaml
variables:
  CI_DEBUG_TRACE: "true"
```

## Troubleshooting

### Cache Not Working
- Verify cache key is correctly configured
- Check runner has access to cache storage
- Clear cache: **CI/CD** → **Pipelines** → **Clear runner caches**

### Job Stuck/Pending
- Check runner availability
- Verify runner tags match job requirements
- Ensure runner has capacity

### Permission Errors
- Check project access tokens
- Verify runner permissions
- Review protected branch settings

### Docker Image Pull Failures
- Verify image exists and is accessible
- Check Docker Hub rate limits
- Use GitLab Container Registry for private images

## Cost Optimization

- Use caching to reduce build time
- Optimize Docker images (use smaller base images)
- Cancel redundant pipelines
- Use interruptible jobs
- Limit artifact retention

## Resources

- [GitLab CI/CD Documentation](https://docs.gitlab.com/ee/ci/)
- [.gitlab-ci.yml Reference](https://docs.gitlab.com/ee/ci/yaml/)
- [GitLab CI/CD Examples](https://docs.gitlab.com/ee/ci/examples/)
- [GitLab Runners](https://docs.gitlab.com/runner/)
- [GitLab CI/CD Pricing](https://about.gitlab.com/pricing/)
