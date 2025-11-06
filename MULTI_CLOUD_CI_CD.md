# Multi-Cloud CI/CD Support Guide

This guide provides comprehensive information about using the Cloud Service Management System across multiple CI/CD platforms.

## Overview

The Cloud Service Management System now supports **multi-cloud CI/CD providers**, allowing you to run your workflows on:

- ✅ **GitHub Actions** (Default)
- ✅ **Azure DevOps Pipelines**
- ✅ **Google Cloud Build**
- ✅ **AWS CodeBuild/CodePipeline**
- ✅ **GitLab CI/CD**
- ✅ **CircleCI**

Each platform has equivalent workflow configurations that provide the same core functionality:
- Automated builds on code changes
- Pull/Merge request validation
- Dependency caching for faster builds
- Node.js 20.x environment setup
- Extensible for custom build and test steps

## Platform Comparison

| Feature | GitHub Actions | Azure Pipelines | Google Cloud Build | AWS CodeBuild | GitLab CI/CD | CircleCI |
|---------|---------------|----------------|-------------------|---------------|--------------|----------|
| **Free Tier** | 2,000 min/month | 1,800 min/month | 120 builds/day | 100 min/month | 400 min/month | 2,500 credits/week |
| **Pricing Model** | Per minute | Per minute | Per build minute | Per build minute | Per minute | Credit-based |
| **Hosted Runners** | ✅ Yes | ✅ Yes | ✅ Yes | ✅ Yes | ✅ Yes | ✅ Yes |
| **Self-Hosted** | ✅ Yes | ✅ Yes | ❌ No | ❌ No | ✅ Yes | ✅ Yes |
| **Caching** | ✅ Built-in | ✅ Built-in | ✅ Built-in | ✅ S3-based | ✅ Built-in | ✅ Built-in |
| **Matrix Builds** | ✅ Yes | ✅ Yes | ⚠️ Limited | ⚠️ Limited | ✅ Yes | ✅ Yes |
| **Docker Support** | ✅ Yes | ✅ Yes | ✅ Native | ✅ Yes | ✅ Native | ✅ Native |
| **Secrets Mgmt** | ✅ Built-in | ✅ Built-in | ✅ Secret Manager | ✅ Param Store | ✅ Built-in | ✅ Built-in |

## Quick Start by Platform

### GitHub Actions (Default)
**Location**: `.github/workflows/example-ci.yml`

Already configured and ready to use!

```bash
# View workflow runs
gh workflow view "Example CI with Cache"

# Trigger manually
gh workflow run example-ci.yml
```

📖 [GitHub Actions Documentation](.github/workflows/README.md)

---

### Azure DevOps Pipelines
**Location**: `.azure-pipelines/azure-pipelines.yml`

**Setup Steps**:
1. Navigate to Azure DevOps project
2. Go to Pipelines → New Pipeline
3. Select repository and choose "Existing Azure Pipelines YAML file"
4. Select `.azure-pipelines/azure-pipelines.yml`
5. Run the pipeline

📖 [Azure Pipelines Documentation](.azure-pipelines/README.md)

---

### Google Cloud Build
**Location**: `.google-cloud/cloudbuild.yaml`

**Setup Steps**:
```bash
# Enable Cloud Build API
gcloud services enable cloudbuild.googleapis.com

# Create trigger for main branch
gcloud builds triggers create github \
  --name="cloud-service-ci" \
  --repo-name="Cloud-Service-Management-System-" \
  --repo-owner="YOUR-GITHUB-USERNAME" \
  --branch-pattern="^main$" \
  --build-config=".google-cloud/cloudbuild.yaml"
```

📖 [Google Cloud Build Documentation](.google-cloud/README.md)

---

### AWS CodeBuild
**Location**: `.aws/buildspec.yml`

**Setup Steps**:
```bash
# Create CodeBuild project
aws codebuild create-project \
  --name cloud-service-management-build \
  --source type=GITHUB,location=https://github.com/YOUR-USERNAME/YOUR-REPO.git \
  --artifacts type=NO_ARTIFACTS \
  --environment type=LINUX_CONTAINER,image=aws/codebuild/standard:7.0,computeType=BUILD_GENERAL1_SMALL \
  --service-role arn:aws:iam::ACCOUNT_ID:role/CodeBuildServiceRole \
  --buildspec .aws/buildspec.yml
```

📖 [AWS CodeBuild Documentation](.aws/README.md)

---

### GitLab CI/CD
**Location**: `.gitlab/.gitlab-ci.yml`

**Setup Steps**:
1. Copy `.gitlab/.gitlab-ci.yml` to `.gitlab-ci.yml` in repository root
2. Push to GitLab repository (or configure mirroring)
3. Pipeline runs automatically

```bash
# Copy configuration to root
cp .gitlab/.gitlab-ci.yml ./.gitlab-ci.yml
git add .gitlab-ci.yml
git commit -m "Add GitLab CI/CD configuration"
git push
```

📖 [GitLab CI/CD Documentation](.gitlab/README.md)

---

### CircleCI
**Location**: `.circleci/config.yml`

**Setup Steps**:
1. Log in to [CircleCI](https://app.circleci.com/)
2. Go to Projects → Find your repository
3. Click "Set Up Project"
4. CircleCI detects `.circleci/config.yml` automatically
5. Start building

📖 [CircleCI Documentation](.circleci/README.md)

---

## Configuration Files Overview

### File Structure
```
.
├── .github/workflows/
│   ├── example-ci.yml              # GitHub Actions workflow
│   └── README.md
├── .azure-pipelines/
│   ├── azure-pipelines.yml         # Azure DevOps pipeline
│   └── README.md
├── .google-cloud/
│   ├── cloudbuild.yaml             # Google Cloud Build config
│   └── README.md
├── .aws/
│   ├── buildspec.yml               # AWS CodeBuild spec
│   └── README.md
├── .gitlab/
│   ├── .gitlab-ci.yml              # GitLab CI/CD pipeline
│   └── README.md
├── .circleci/
│   ├── config.yml                  # CircleCI configuration
│   └── README.md
└── MULTI_CLOUD_CI_CD.md           # This guide
```

### Common Patterns

All configurations follow these patterns:

1. **Trigger on**:
   - Push to `main` branch
   - Pull/Merge requests to `main` branch

2. **Environment**:
   - Ubuntu/Linux-based runners
   - Node.js 20.x runtime

3. **Caching**:
   - npm dependencies cached
   - `node_modules` cached

4. **Build Steps**:
   - Checkout code
   - Setup Node.js
   - Restore cache
   - Install dependencies (if cache miss)
   - Run build
   - Run tests
   - Save cache

## Choosing the Right Platform

### Use GitHub Actions if:
- ✅ Repository hosted on GitHub
- ✅ Need tight GitHub integration
- ✅ Want marketplace actions
- ✅ Prefer YAML-based configuration

### Use Azure DevOps Pipelines if:
- ✅ Using Azure cloud services
- ✅ Need enterprise features
- ✅ Want integrated boards and repos
- ✅ Require advanced approval workflows

### Use Google Cloud Build if:
- ✅ Running on Google Cloud Platform
- ✅ Need fast container builds
- ✅ Want deep GCP integration
- ✅ Prefer Docker-native workflows

### Use AWS CodeBuild if:
- ✅ Infrastructure on AWS
- ✅ Using AWS CodePipeline
- ✅ Need VPC integration
- ✅ Want pay-per-use pricing

### Use GitLab CI/CD if:
- ✅ Repository on GitLab
- ✅ Need complete DevOps platform
- ✅ Want built-in registry and monitoring
- ✅ Prefer all-in-one solution

### Use CircleCI if:
- ✅ Need advanced caching
- ✅ Want SSH debugging
- ✅ Require matrix builds
- ✅ Prefer config validation tools

## Migration Guide

### From GitHub Actions to Another Platform

1. **Identify equivalent concepts**:
   - `uses: actions/checkout` → Platform's checkout step
   - `uses: actions/cache` → Platform's cache mechanism
   - `runs-on: ubuntu-latest` → Platform's runner/image

2. **Copy the appropriate config file**
3. **Adjust environment variables**
4. **Test the new pipeline**
5. **Optionally disable GitHub Actions**

### From Another Platform to GitHub Actions

1. Review the `.github/workflows/example-ci.yml` file
2. Adapt any custom build/test steps
3. Configure secrets in GitHub repository settings
4. Push changes and verify workflow runs

## Best Practices for Multi-Cloud

### 1. Keep Configurations in Sync
When making changes, update all platform configurations to maintain parity:

```bash
# Example: Update Node.js version across all platforms
# Update in each config file:
# - .github/workflows/example-ci.yml: node-version: '22'
# - .azure-pipelines/azure-pipelines.yml: NODE_VERSION: '22.x'
# - .google-cloud/cloudbuild.yaml: image: node:22
# - .aws/buildspec.yml: nodejs: 22
# - .gitlab/.gitlab-ci.yml: image: node:22
# - .circleci/config.yml: image: cimg/node:22
```

### 2. Use Environment Variables
Store configuration in environment variables rather than hardcoding:

```yaml
# Good
- run: echo "API URL: $API_URL"

# Avoid
- run: echo "API URL: https://hardcoded.example.com"
```

### 3. Document Platform-Specific Features
If using platform-specific features, document them clearly:

```yaml
# This uses GitHub Actions specific feature
# Equivalent in other platforms: [provide alternatives]
- uses: actions/github-script@v7
```

### 4. Test on Multiple Platforms
Before major releases, verify builds work on all configured platforms.

### 5. Use .gitignore for Platform Files
If not using all platforms, add unused configs to `.gitignore`:

```gitignore
# If not using GitLab
.gitlab-ci.yml

# If not using CircleCI
.circleci/
```

## Monitoring and Troubleshooting

### Check Build Status

| Platform | Command/URL |
|----------|-------------|
| **GitHub Actions** | `gh run list` or GitHub Actions tab |
| **Azure Pipelines** | Azure DevOps Pipelines dashboard |
| **Google Cloud** | `gcloud builds list` or Cloud Console |
| **AWS CodeBuild** | `aws codebuild list-builds` or AWS Console |
| **GitLab CI/CD** | GitLab CI/CD → Pipelines |
| **CircleCI** | CircleCI Pipelines dashboard |

### Common Issues

#### Cache Not Working
- **Cause**: Cache key doesn't match or cache storage full
- **Solution**: Verify cache key format matches platform requirements

#### Build Timeout
- **Cause**: Default timeout too short
- **Solution**: Increase timeout in platform configuration

#### Permission Denied
- **Cause**: Service account lacks necessary permissions
- **Solution**: Review and update IAM/permission settings

#### Environment Variable Not Found
- **Cause**: Variable not set in platform settings
- **Solution**: Add variable in platform's secrets/variables section

## Security Considerations

### Secrets Management

Each platform has its own secrets management:

- **GitHub Actions**: Repository Settings → Secrets and variables
- **Azure Pipelines**: Variable groups or Azure Key Vault
- **Google Cloud Build**: Secret Manager integration
- **AWS CodeBuild**: Parameter Store or Secrets Manager
- **GitLab CI/CD**: Settings → CI/CD → Variables
- **CircleCI**: Project Settings → Environment Variables or Contexts

### Best Practices
1. ✅ Never commit secrets to version control
2. ✅ Use platform's native secrets management
3. ✅ Rotate secrets regularly
4. ✅ Use least-privilege access
5. ✅ Enable audit logging
6. ✅ Mask sensitive values in logs

## Cost Optimization

### Tips for All Platforms

1. **Cache Aggressively**: Reduce build times and costs
2. **Right-size Resources**: Don't over-provision compute
3. **Skip Unnecessary Builds**: Use path filters
4. **Optimize Docker Images**: Use smaller base images
5. **Monitor Usage**: Track build minutes/credits regularly
6. **Clean Up Artifacts**: Set retention policies
7. **Use Schedules Wisely**: Avoid unnecessary scheduled runs

### Free Tier Optimization

| Platform | Free Tier | Optimization Strategy |
|----------|-----------|----------------------|
| GitHub | 2,000 min/month | Use path filters, cancel redundant runs |
| Azure | 1,800 min/month | Enable parallel jobs efficiently |
| Google | 120 builds/day | Optimize build time, use prebuilt images |
| AWS | 100 min/month | Use caching, right-size compute |
| GitLab | 400 min/month | Share runners, optimize cache |
| CircleCI | 2,500 credits/week | Use appropriate resource classes |

## Support and Resources

### Official Documentation
- [GitHub Actions Docs](https://docs.github.com/actions)
- [Azure Pipelines Docs](https://docs.microsoft.com/azure/devops/pipelines/)
- [Google Cloud Build Docs](https://cloud.google.com/build/docs)
- [AWS CodeBuild Docs](https://docs.aws.amazon.com/codebuild/)
- [GitLab CI/CD Docs](https://docs.gitlab.com/ee/ci/)
- [CircleCI Docs](https://circleci.com/docs/)

### Community Support
- GitHub Discussions
- Stack Overflow
- Platform-specific forums
- Discord/Slack communities

### Getting Help

If you encounter issues:
1. Check the platform-specific README in this repository
2. Review official documentation
3. Search community forums
4. Contact platform support
5. Open an issue in this repository

## Contributing

To add support for additional CI/CD platforms:

1. Create a new directory for the platform (e.g., `.jenkins/`)
2. Add the configuration file with equivalent functionality
3. Create a comprehensive README.md in the directory
4. Update this guide with platform information
5. Update the main README.md
6. Submit a pull request

### Platforms We'd Love to See
- Jenkins
- Travis CI
- Drone CI
- Buildkite
- TeamCity
- Bamboo
- Bitbucket Pipelines

## Changelog

### Version 1.0.0 (2024)
- ✅ Initial multi-cloud support
- ✅ GitHub Actions (existing)
- ✅ Azure DevOps Pipelines
- ✅ Google Cloud Build
- ✅ AWS CodeBuild/CodePipeline
- ✅ GitLab CI/CD
- ✅ CircleCI
- ✅ Comprehensive documentation for each platform

---

**Need help?** Check the platform-specific README files or open an issue!
