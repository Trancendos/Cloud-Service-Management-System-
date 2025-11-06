# Cloud-Service-Management-System-
Management and deployment of GitHub services at 0 costs models

## Features

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
