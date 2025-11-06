# Cloud Service Management System

Management and deployment of cloud services across multiple CI/CD platforms at minimal cost.

## 🚀 Multi-Cloud CI/CD Support

This repository now supports **multiple CI/CD platforms**, allowing you to run your workflows on your preferred cloud provider:

| Platform | Status | Configuration |
|----------|--------|---------------|
| **GitHub Actions** | ✅ Active | [.github/workflows/](.github/workflows/) |
| **Azure DevOps** | ✅ Ready | [.azure-pipelines/](.azure-pipelines/) |
| **Google Cloud Build** | ✅ Ready | [.google-cloud/](.google-cloud/) |
| **AWS CodeBuild** | ✅ Ready | [.aws/](.aws/) |
| **GitLab CI/CD** | ✅ Ready | [.gitlab/](.gitlab/) |
| **CircleCI** | ✅ Ready | [.circleci/](.circleci/) |

### Quick Start

Choose your platform and get started:

- 📘 **[GitHub Actions](.github/workflows/README.md)** - Default, already configured
- 📙 **[Azure DevOps Pipelines](.azure-pipelines/README.md)** - Enterprise CI/CD with Azure integration
- 📗 **[Google Cloud Build](.google-cloud/README.md)** - Fast container-native builds on GCP
- 📕 **[AWS CodeBuild](.aws/README.md)** - Fully managed build service on AWS
- 📔 **[GitLab CI/CD](.gitlab/README.md)** - Complete DevOps platform
- 📓 **[CircleCI](.circleci/README.md)** - Modern CI/CD with advanced features

📖 **[Read the complete Multi-Cloud CI/CD Guide](MULTI_CLOUD_CI_CD.md)** for detailed setup instructions, migration guides, and best practices.

## Features

- ✅ **Multi-Platform Support**: Run workflows on GitHub Actions, Azure, GCP, AWS, GitLab, or CircleCI
- ✅ **Dependency Caching**: Optimized caching for faster builds across all platforms
- ✅ **Automated Updates**: Auto-fix deprecated actions (GitHub Actions)
- ✅ **Cost Optimized**: Configurations designed to maximize free tier usage
- ✅ **Well Documented**: Comprehensive documentation for each platform
- ✅ **Easy Migration**: Move between platforms with equivalent configurations

## Repository Structure

```
.
├── .github/workflows/          # GitHub Actions workflows
│   ├── example-ci.yml         # Example CI workflow with caching
│   ├── auto-fix-deprecated-actions.yml
│   └── README.md
├── .azure-pipelines/          # Azure DevOps configuration
│   ├── azure-pipelines.yml
│   └── README.md
├── .google-cloud/             # Google Cloud Build configuration
│   ├── cloudbuild.yaml
│   └── README.md
├── .aws/                      # AWS CodeBuild configuration
│   ├── buildspec.yml
│   └── README.md
├── .gitlab/                   # GitLab CI/CD configuration
│   ├── .gitlab-ci.yml
│   └── README.md
├── .circleci/                 # CircleCI configuration
│   ├── config.yml
│   └── README.md
├── MULTI_CLOUD_CI_CD.md      # Complete multi-cloud guide
└── README.md                  # This file
```

## Getting Started

### For GitHub Actions (Default)

The repository is already configured with GitHub Actions. Workflows will run automatically on:
- Push to `main` branch
- Pull requests to `main` branch

View workflow runs in the **Actions** tab.

### For Other Platforms

1. Choose your preferred CI/CD platform
2. Follow the setup guide in the platform's README
3. Configure the platform to use the provided configuration file
4. Start building!

Detailed instructions for each platform are available in their respective README files.

## Documentation

- **[Multi-Cloud CI/CD Guide](MULTI_CLOUD_CI_CD.md)** - Comprehensive guide covering all platforms
- **[GitHub Actions Workflows](.github/workflows/README.md)** - GitHub Actions documentation
- **Platform-Specific Guides** - See individual directories for detailed platform documentation

## Best Practices

1. **Choose the Right Platform**: Review the [platform comparison](MULTI_CLOUD_CI_CD.md#platform-comparison) to select the best fit
2. **Leverage Caching**: All configurations include dependency caching for faster builds
3. **Monitor Usage**: Track your CI/CD usage to stay within free tier limits
4. **Keep Configs in Sync**: If using multiple platforms, maintain configuration parity
5. **Secure Your Secrets**: Use platform-native secrets management

## Cost Optimization

All configurations are optimized for cost efficiency:

- **Free Tier Friendly**: Designed to work within free tier limits
- **Efficient Caching**: Reduces build times and costs
- **Smart Triggers**: Only build when necessary
- **Resource Optimization**: Right-sized compute resources

See the [Cost Optimization section](MULTI_CLOUD_CI_CD.md#cost-optimization) in the Multi-Cloud guide for more details.

## Contributing

Contributions are welcome! To add support for additional CI/CD platforms:

1. Create a directory for the new platform
2. Add equivalent configuration files
3. Write comprehensive documentation
4. Update this README and the Multi-Cloud guide
5. Submit a pull request

### Platforms We'd Love to See
- Jenkins
- Travis CI  
- Drone CI
- Buildkite
- TeamCity
- Bamboo

## Support

- 📖 Check platform-specific documentation in individual directories
- 💬 Open an issue for bugs or feature requests
- 🤝 Contribute improvements via pull requests

## License

This project is open source and available for use in your own projects. 
