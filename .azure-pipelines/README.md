# Azure DevOps Pipelines Configuration

This directory contains Azure DevOps Pipeline configuration for the Cloud Service Management System.

## Overview

The `azure-pipelines.yml` file provides equivalent functionality to the GitHub Actions workflow, including:
- Automated builds on push to main branch
- Pull request validation
- Dependency caching
- Node.js 20.x setup

## Setup Instructions

### 1. Prerequisites
- An Azure DevOps organization and project
- Repository connected to Azure DevOps

### 2. Create Pipeline

1. Navigate to your Azure DevOps project
2. Go to **Pipelines** → **New Pipeline**
3. Select your repository source (GitHub, Azure Repos, etc.)
4. Choose **Existing Azure Pipelines YAML file**
5. Select the path: `.azure-pipelines/azure-pipelines.yml`
6. Review and click **Run**

### 3. Configure Triggers

The pipeline is configured to trigger on:
- **Push**: When code is pushed to the `main` branch
- **Pull Request**: When PRs are created targeting the `main` branch

Excluded paths:
- Markdown files (`*.md`)
- GitHub Actions workflows (`.github/**`)
- Other CI/CD configurations

## Key Features

### Caching
The pipeline uses Azure Pipelines Cache task to cache npm dependencies:
```yaml
- task: Cache@2
  inputs:
    key: 'npm | "$(Agent.OS)" | package-lock.json'
    path: |
      $(Pipeline.Workspace)/.npm
      node_modules
```

### Node.js Setup
Uses the NodeTool@0 task to install Node.js 20.x:
```yaml
- task: NodeTool@0
  inputs:
    versionSpec: $(NODE_VERSION)
```

## Customization

### Changing Node.js Version
Update the `NODE_VERSION` variable in the variables section:
```yaml
variables:
  NODE_VERSION: '20.x'
```

### Adding Build Steps
Add additional script tasks in the steps section:
```yaml
- script: |
    npm run build
  displayName: 'Build application'
```

### Adding Tests
Add test execution scripts:
```yaml
- script: |
    npm test
  displayName: 'Run tests'
  condition: succeededOrFailed()
```

## Environment Variables

You can add environment variables in the Azure DevOps UI:
1. Go to **Pipelines** → Select your pipeline → **Edit**
2. Click **Variables** → **New variable**
3. Add name and value (mark as secret if needed)

## Best Practices

1. **Use Latest Versions**: Keep task versions up to date
2. **Cache Dependencies**: Enable caching for faster builds
3. **Fail Fast**: Configure proper conditions for dependent steps
4. **Secure Secrets**: Use Azure Key Vault for sensitive data
5. **Monitor Usage**: Review pipeline usage in Azure DevOps analytics

## Troubleshooting

### Cache Not Working
- Verify the cache key includes the correct file path
- Check that `package-lock.json` exists in the repository
- Review cache hit/miss in pipeline logs

### Node.js Version Issues
- Ensure the specified version is available on Azure-hosted agents
- Check [Microsoft-hosted agents documentation](https://docs.microsoft.com/azure/devops/pipelines/agents/hosted)

### Permission Errors
- Verify pipeline has necessary permissions to access resources
- Check service connection configurations

## Resources

- [Azure Pipelines Documentation](https://docs.microsoft.com/azure/devops/pipelines/)
- [YAML Schema Reference](https://docs.microsoft.com/azure/devops/pipelines/yaml-schema)
- [Azure Pipelines Tasks](https://docs.microsoft.com/azure/devops/pipelines/tasks/)
