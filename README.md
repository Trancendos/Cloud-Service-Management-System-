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
# Cloud-Service-Management-System-
Management and deployment of GitHub services at 0 costs models

## Features

- 🔄 **Automated Action Updates**: Automatically detects and updates deprecated GitHub Actions
- ✅ **Checkpoint Testing**: Validates workflow operations with dummy data and simulated service accounts
- 🤖 **AI Data Validation**: Automated validation of data files with PR comments
- 🎯 **Zero-Cost Model**: Leverages GitHub's free tier for service management
- 📊 **Continuous Validation**: Daily automated testing ensures system reliability

## Workflows

This repository includes several GitHub Actions workflows:

1. **Auto-fix Deprecated Actions** - Automatically updates deprecated actions to latest versions
2. **Example CI with Cache** - Demonstrates best practices for caching and CI workflows
3. **Checkpoint Workflow with Dummy Data** - Validates operations with simulated test scenarios
4. **AI Data Validation** - Validates JSON and YAML data files on every PR

## Getting Started

### Using Checkpoints for Testing

The checkpoint workflow provides automated validation of workflow operations using dummy data:

```bash
# Manually trigger the checkpoint workflow from the Actions tab
# or it runs automatically daily at 3:00 AM UTC
```

See the [Checkpoint Testing Guide](CHECKPOINT-GUIDE.md) for detailed instructions on:
- Running checkpoint validations
- Understanding checkpoint results
- Customizing test scenarios
- Adding new service account simulations

### Test Data

The `test-data/` directory contains:
- `dummy-service-accounts.json` - Simulated service accounts with permissions
- `dummy-workflow-data.json` - Test scenarios and expected outcomes

⚠️ **Note**: All test data uses dummy credentials for simulation only.

### Data Validation

The repository includes automated data validation that runs on every PR:
- Validates JSON files in `test-data/`
- Validates YAML configuration files for all supported platforms
- Posts validation reports as PR comments
- Total of 7 critical data files are validated

Run validation manually:
```bash
./scripts/validate-data.sh
```

## Documentation

- [Workflows README](.github/workflows/README.md) - Detailed workflow documentation
- [Checkpoint Guide](CHECKPOINT-GUIDE.md) - Complete guide to checkpoint testing
- [Test Data README](test-data/README.md) - Information about test data structure

## Contributing

When contributing:
1. Use latest stable versions of GitHub Actions
2. Test changes with the checkpoint workflow
3. Update documentation as needed
4. Follow existing patterns and conventions. 
### 🔔 Automated Notifications
Get instant notifications for workflow runs and pull requests via:
- **Slack**: Rich formatted messages with action buttons
- **Email**: Detailed email notifications
- **GitHub Comments**: Automated PR comments for workflow results

### 🔧 Auto-fix Deprecated Actions
Automatically detect and update deprecated GitHub Actions to their latest versions.

### 📦 Example CI Workflows
Modern CI workflow templates using the latest GitHub Actions.

## Quick Start

### Enable Notifications

1. **Set repository variables** (Settings → Secrets and variables → Actions → Variables):
   ```
   ENABLE_SLACK_NOTIFICATIONS=true
   ENABLE_EMAIL_NOTIFICATIONS=true
   ENABLE_GITHUB_COMMENTS=true
   ```

2. **Configure secrets** for your notification channels:
   - **Slack**: Add `SLACK_WEBHOOK_URL`
   - **Email**: Add `MAIL_SERVER`, `MAIL_PORT`, `MAIL_USERNAME`, `MAIL_PASSWORD`, `MAIL_FROM`, `NOTIFICATION_EMAIL`
   - **GitHub**: No additional secrets needed!

3. **Done!** Notifications work automatically.

See [.github/workflows/NOTIFICATIONS.md](.github/workflows/NOTIFICATIONS.md) for detailed setup instructions.

## Documentation

- [Workflows README](.github/workflows/README.md) - Overview of all workflows
- [Notifications Setup](.github/workflows/NOTIFICATIONS.md) - Complete notification configuration guide

## Workflows

- **workflow-notifications.yml** - Sends notifications when workflows complete
- **pr-notifications.yml** - Sends notifications for PR events
- **auto-fix-deprecated-actions.yml** - Automatically updates deprecated actions
- **example-ci.yml** - Template for modern CI workflows

## Contributing

Contributions are welcome! Please ensure:
- Use latest action versions
- Follow existing workflow patterns
- Test thoroughly before creating PRs
- Include clear documentation
Management and deployment of GitHub services at 0 costs models 

## Features

### Automated Action Updates with Enhanced Validation
This repository includes an automated workflow (`auto-fix-deprecated-actions.yml`) that:
- Automatically detects and updates deprecated GitHub Actions
- Performs comprehensive validation before creating pull requests
- Ensures all changes are safe and reliable

#### Validation Steps
1. **YAML Syntax Validation** - Verifies all workflow files have correct YAML syntax
2. **Workflow Structure Validation** - Ensures workflows contain required fields (on, jobs)
3. **Action Version Verification** - Confirms that updated action versions exist and are accessible

#### Supported Action Updates
- `actions/cache@v1,v2` → `actions/cache@v4`
- `actions/checkout@v1,v2` → `actions/checkout@v4`
- `actions/setup-node@v1,v2` → `actions/setup-node@v4`
- `actions/setup-python@v1,v2` → `actions/setup-python@v5`

## Workflows

### Example CI (`example-ci.yml`)
A basic CI workflow demonstrating:
- Checkout code
- Setup Node.js environment
- Dependency caching
- Build steps

### Auto-fix Deprecated Actions (`auto-fix-deprecated-actions.yml`)
An automated maintenance workflow that:
- Runs weekly on Mondays at 9:00 AM UTC
- Can be triggered manually via workflow_dispatch
- Scans all workflow files for deprecated actions
- Creates pull requests with validated updates
- Includes comprehensive validation before PR creation

# Cloud Service Management System

Management and deployment of GitHub services at 0 costs models with comprehensive debugging and logging capabilities.

## Features

### 🔍 Debugging and Logging
- **Comprehensive Logging Library**: Full-featured shell script logging with multiple log levels (DEBUG, INFO, WARN, ERROR, FATAL)
- **Deep Error Reporting**: Stack traces, error handling, and automatic error trapping
- **Traceability**: Function entry/exit tracing for detailed execution flow tracking
- **Performance Monitoring**: Built-in timers for tracking operation durations
- **Structured Logging**: JSON output support for log aggregation systems
- **GitHub Actions Integration**: Reusable debugging workflows for CI/CD pipelines

### ⚙️ GitHub Actions Workflows
- **Auto-fix Deprecated Actions**: Automatically updates deprecated GitHub Actions
- **Example CI with Caching**: Demonstrates modern CI/CD best practices
- **Reusable Debug Workflow**: Configurable debugging workflow for troubleshooting
- **Debug Example**: Complete example of logging integration in workflows

## Quick Start

### Using the Logging Library

```bash
# Source the logging library
source scripts/logging.sh

# Configure logging
export LOG_LEVEL=0  # DEBUG level
export VERBOSE=true

# Use logging functions
log_info "Starting operation..."
log_exec npm install
log_success "Operation completed!"
```

### Running the Example

```bash
# Make scripts executable
chmod +x scripts/logging_example.sh

# Run the demo
./scripts/logging_example.sh
```

### Using in GitHub Actions

```yaml
jobs:
  my-job:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Setup logging
        run: |
          chmod +x scripts/logging.sh
          export LOG_LEVEL=0
          export VERBOSE=true
      
      - name: Run with logging
        run: |
          source scripts/logging.sh
          log_info "Starting build..."
          log_exec npm run build
          log_success "Build completed!"
```

## Documentation

- 📖 [Debugging and Logging Guide](docs/DEBUGGING_AND_LOGGING.md) - Complete guide to logging features
- 📁 [Scripts Documentation](scripts/README.md) - Details about utility scripts
- 🔧 [Workflows Documentation](.github/workflows/README.md) - GitHub Actions workflows guide

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
├── .github/
│   └── workflows/
│       ├── auto-fix-deprecated-actions.yml  # Auto-update deprecated actions
│       ├── example-ci.yml                    # CI example with caching
│       ├── reusable-debug.yml                # Reusable debugging workflow
│       ├── debug-example.yml                 # Debugging integration example
│       └── README.md                         # Workflows documentation
├── docs/
│   └── DEBUGGING_AND_LOGGING.md             # Comprehensive logging guide
├── scripts/
│   ├── logging.sh                            # Logging library
│   ├── logging_example.sh                    # Usage examples
│   └── README.md                             # Scripts documentation
└── README.md                                 # This file
```

## Key Features

### Logging Library Functions

- **Log Levels**: `log_debug`, `log_info`, `log_warn`, `log_error`, `log_fatal`
- **Special Messages**: `log_success`, `log_failure`, `log_section`
- **Debugging**: `log_stack_trace`, `log_env_vars`, `log_vars`
- **Command Execution**: `log_exec` (with automatic timing)
- **Function Tracing**: `log_enter`, `log_exit`
- **Error Handling**: `setup_error_trap`, `setup_debug_mode`
- **Assertions**: `assert`, `require_command`
- **Performance**: `timer_start`, `timer_stop`
- **Structured Logging**: `log_json`

### Configuration Options

Control logging behavior with environment variables:

```bash
export LOG_LEVEL=0           # 0=DEBUG, 1=INFO, 2=WARN, 3=ERROR, 4=FATAL
export VERBOSE=true          # Add caller information
export LOG_FILE="/path/log"  # Write to file
export STACK_TRACE_DEPTH=10  # Stack trace frames
export JSON_ONLY=true        # JSON-only output
```

## Examples

### Basic Logging
```bash
source scripts/logging.sh
log_info "Application started"
log_warn "Low disk space"
log_error "Failed to connect"
```

### Error Handling with Stack Traces
```bash
source scripts/logging.sh
setup_error_trap  # Auto-log errors

# Script automatically logs errors with stack traces
risky_operation || log_error "Operation failed"
```

### Performance Monitoring
```bash
source scripts/logging.sh

timer_start "deployment"
deploy_application
duration=$(timer_stop "deployment")
log_info "Deployment took ${duration}s"
```

### Structured Logging
```bash
source scripts/logging.sh
export JSON_ONLY=true

log_json $LOG_LEVEL_INFO "user_login" \
    "user_id" "12345" \
    "ip" "192.168.1.1"
```

## Contributing

Contributions are welcome! Please:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

This project is part of the Cloud Service Management System.

## Support

For questions or issues:
- Check the [documentation](docs/DEBUGGING_AND_LOGGING.md)
- Review [example scripts](scripts/logging_example.sh)
- Open an issue on GitHub 
