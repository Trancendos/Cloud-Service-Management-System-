# GitHub Copilot Instructions

This repository is a **Cloud Service Management System** focused on multi-cloud CI/CD configurations and GitHub Actions workflows with a zero-cost deployment model.

## Repository Overview

This repository provides CI/CD configurations and workflows for multiple cloud platforms (GitHub Actions, Azure DevOps, Google Cloud Build, AWS CodeBuild, GitLab CI/CD, CircleCI) along with automation tools for maintaining GitHub Actions workflows.

## Build & Test Process

### Building
This repository primarily consists of:
- **YAML configuration files** for CI/CD workflows
- **Shell scripts** for automation and validation
- **Markdown documentation**

There is no traditional build process. To validate changes:

```bash
# Validate YAML syntax for all workflow files
./validate-configs.sh

# Validate test data files
./scripts/validate-test-data.sh

# Validate all data files (JSON, YAML)
./scripts/validate-data.sh
```

### Testing
- Run `./validate-configs.sh` to validate all CI/CD configuration files
- Run `./scripts/validate-test-data.sh` to validate test data in `test-data/` directory
- Run `./scripts/validate-data.sh` to validate all data files
- Shell scripts can be tested by executing them in a bash environment
- GitHub Actions workflows are tested via the checkpoint workflow (`.github/workflows/checkpoint-workflow.yml`)

### Linting
- **YAML files**: Use `yamllint` or built-in YAML validators
- **Shell scripts**: Use `shellcheck` for bash script linting
- **Markdown**: Use `markdownlint` for documentation files
- Validation scripts automatically check syntax

## Repository Structure

```
.
├── .github/
│   └── workflows/           # GitHub Actions workflow files
│       ├── *.yml           # Individual workflow files
│       ├── README.md       # Workflow documentation
│       └── *.md            # Specific workflow guides
├── .azure-pipelines/       # Azure DevOps pipeline configurations
├── .google-cloud/          # Google Cloud Build configurations
├── .aws/                   # AWS CodeBuild configurations
├── .gitlab/                # GitLab CI/CD configurations
├── .circleci/              # CircleCI configurations
├── scripts/                # Automation and utility scripts
│   ├── logging.sh         # Logging library for shell scripts
│   └── validate-*.sh      # Validation scripts
├── test-data/              # Test data for checkpoint workflows
├── docs/                   # Documentation
└── *.md                    # Root-level documentation files
```

## Key Conventions

### GitHub Actions Workflows
- Use latest stable action versions (e.g., `actions/checkout@v4`, `actions/setup-node@v4`)
- Always include dependency caching to optimize build times
- Use descriptive job and step names
- Follow the pattern established in `example-ci.yml`
- Workflows should be optimized for GitHub's free tier
- Name workflows clearly: `workflow-name.yml`

### Shell Scripts
- All scripts should be executable (`chmod +x`)
- Use the logging library (`scripts/logging.sh`) for consistent logging
- Include error handling with `set -e` or equivalent
- Add usage/help information for user-facing scripts
- Follow bash best practices for portability

### Documentation
- Keep README files up-to-date in each directory
- Use markdown for all documentation
- Include clear examples and code snippets
- Document configuration options and environment variables

### CI/CD Configurations
- Maintain configuration parity across platforms when possible
- Include comments explaining complex configurations
- Optimize for cost (free tier usage)
- Use caching strategies for dependencies
- Keep secrets and sensitive data in platform-native secret management

## File Naming Conventions
- Workflows: `kebab-case.yml` (e.g., `auto-fix-deprecated-actions.yml`)
- Scripts: `kebab-case.sh` (e.g., `validate-data.sh`)
- Documentation: `UPPERCASE_WITH_UNDERSCORES.md` for guides, `README.md` for directory docs
- Test data: `dummy-*.json` for simulated data

## Important Directories

### `.github/workflows/`
Contains all GitHub Actions workflow definitions. Each workflow should:
- Have a clear purpose documented in comments or README
- Use appropriate triggers (`on:` conditions)
- Include necessary permissions
- Follow the caching pattern from `example-ci.yml`

### `scripts/`
Shell scripts for automation:
- `logging.sh`: Core logging library (source this in other scripts)
- `validate-*.sh`: Validation scripts for configs and data
- All scripts should be documented in `scripts/README.md`

### `test-data/`
Contains dummy/test data for checkpoint workflows:
- `dummy-service-accounts.json`: Simulated service accounts
- `dummy-workflow-data.json`: Test scenarios
- Never use real credentials or sensitive data

### `docs/`
Comprehensive documentation:
- Feature-specific guides
- Best practices documents
- Platform-specific instructions

## Special Features

### Auto-fix Deprecated Actions
The repository includes automated workflows to update deprecated GitHub Actions:
- Runs weekly via `auto-fix-deprecated-actions.yml`
- Creates PRs with validated updates
- Includes YAML syntax validation before committing

### AI-Powered Features
- **AI Code Review**: Automated code review on PRs
- **AI Data Validation**: Validates JSON/YAML files for syntax and security
- Uses GitHub Actions for automation

### Notification System
Support for multiple notification channels:
- Slack webhooks
- Email notifications
- GitHub PR comments
- Configured via repository variables and secrets

### Logging Library
Comprehensive shell script logging (`scripts/logging.sh`):
- Multiple log levels (DEBUG, INFO, WARN, ERROR, FATAL)
- Stack traces and error handling
- Performance monitoring with timers
- JSON output support for log aggregation
- Use `source scripts/logging.sh` to enable in your scripts

## Zero-Cost Model
This repository is designed to operate within free tiers:
- GitHub Actions: 2,000 minutes/month for free accounts
- Optimize workflows to minimize execution time
- Use caching extensively
- Avoid unnecessary workflow runs with appropriate triggers

## When Making Changes

### Adding New Workflows
1. Create workflow in `.github/workflows/`
2. Use latest action versions
3. Include caching where applicable
4. Add documentation to `.github/workflows/README.md`
5. Test with dummy data if applicable
6. Validate YAML syntax with `./validate-configs.sh`

### Modifying Scripts
1. Ensure scripts remain executable
2. Use the logging library for output
3. Update `scripts/README.md` if adding new scripts
4. Test in a bash environment
5. Run `shellcheck` for linting

### Updating Documentation
1. Keep structure consistent with existing docs
2. Update table of contents if adding sections
3. Cross-reference related documents
4. Include practical examples
5. Update root README.md if changing major features

### Working with Multi-Cloud Configs
1. Changes to one platform may require equivalent changes to others
2. Document platform-specific differences
3. Maintain configuration parity when possible
4. Update `MULTI_CLOUD_CI_CD.md` for significant changes

## Common Tasks

### Validate All Configurations
```bash
./validate-configs.sh
```

### Run Checkpoint Workflow
Trigger manually from GitHub Actions UI or wait for scheduled run (daily at 3:00 AM UTC).

### Update GitHub Actions
The auto-fix workflow runs weekly, or trigger manually from the Actions tab.

### Test Shell Scripts Locally
```bash
chmod +x scripts/your-script.sh
./scripts/your-script.sh
```

### Review AI Validations
AI code review and data validation run automatically on PRs. Review comments in the PR.

## Security Considerations
- Never commit real credentials or secrets
- Use GitHub Secrets for sensitive values
- Test data should use dummy/fake values
- Validate all external inputs
- Keep dependencies updated
- Review AI-generated security warnings carefully

## Questions or Issues?
- Check the comprehensive documentation in `docs/`
- Review platform-specific READMEs
- Consult `MULTI_CLOUD_CI_CD.md` for multi-cloud guidance
- Open an issue for bugs or feature requests
