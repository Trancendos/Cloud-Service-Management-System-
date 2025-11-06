# Debugging and Logging Guide

This guide provides comprehensive documentation for the debugging and logging capabilities in the Cloud Service Management System.

## Table of Contents

1. [Overview](#overview)
2. [Logging Library](#logging-library)
3. [GitHub Actions Integration](#github-actions-integration)
4. [Quick Start](#quick-start)
5. [Advanced Usage](#advanced-usage)
6. [Best Practices](#best-practices)
7. [Troubleshooting](#troubleshooting)

## Overview

The Cloud Service Management System includes a robust logging and debugging framework designed to provide:

- **Deep Error Reporting**: Comprehensive error messages with stack traces
- **Traceability**: Track execution flow through function entry/exit logging
- **Performance Monitoring**: Built-in timing and performance metrics
- **Flexible Log Levels**: Control verbosity from DEBUG to FATAL
- **Structured Logging**: JSON output support for log aggregation systems
- **GitHub Actions Integration**: Reusable workflows for debugging CI/CD pipelines

## Logging Library

### Features

The logging library (`scripts/logging.sh`) provides:

#### Log Levels
- `DEBUG` (0): Detailed diagnostic information
- `INFO` (1): General informational messages
- `WARN` (2): Warning messages for potentially problematic situations
- `ERROR` (3): Error messages for failures
- `FATAL` (4): Critical errors that cause script termination

#### Core Functions

##### Basic Logging
```bash
log_debug "Detailed diagnostic information"
log_info "General information"
log_warn "Warning message"
log_error "Error occurred"
log_fatal "Critical error - will exit"
log_success "Operation completed successfully"
log_failure "Operation failed"
log_section "Section Header"
```

##### Debugging Functions
```bash
# Print stack trace
log_stack_trace

# Dump environment variables
log_env_vars

# Dump specific variables
log_vars VAR1 VAR2 VAR3

# Execute command with timing
log_exec command arg1 arg2

# Function entry/exit tracing
log_enter "param1" "param2"
log_exit 0
```

##### Error Handling
```bash
# Setup automatic error logging
setup_error_trap

# Setup exit logging
setup_exit_trap

# Enable full debug mode
setup_debug_mode

# Assert conditions
assert "[ -f file.txt ]" "File should exist"

# Require commands
require_command "git" "Git is required"
```

##### Performance Monitoring
```bash
# Start a timer
timer_start "operation_name"

# Stop timer and log duration
duration=$(timer_stop "operation_name")
```

##### Structured Logging
```bash
# Log in JSON format
log_json $LOG_LEVEL_INFO "User login" "user_id" "123" "ip" "192.168.1.1"
```

### Configuration

Configure logging behavior with environment variables:

```bash
# Set log level (0=DEBUG, 1=INFO, 2=WARN, 3=ERROR, 4=FATAL)
export LOG_LEVEL=0

# Enable verbose mode (adds caller information)
export VERBOSE=true

# Write logs to file (optional)
export LOG_FILE="/var/log/myapp.log"

# Set stack trace depth
export STACK_TRACE_DEPTH=10

# Enable JSON-only output
export JSON_ONLY=true
```

## GitHub Actions Integration

### Reusable Debug Workflow

The system includes a reusable debugging workflow (`.github/workflows/reusable-debug.yml`) that can be integrated into any workflow.

#### Features

- Configurable log levels
- Verbose mode for detailed output
- Step-by-step command tracing
- Automatic log collection and artifact upload
- System information reporting
- Environment variable dumping

#### Usage

```yaml
jobs:
  debug:
    uses: ./.github/workflows/reusable-debug.yml
    with:
      debug_level: 'DEBUG'        # DEBUG, INFO, WARN, ERROR
      verbose: true               # Enable verbose output
      enable_tracing: false       # Enable bash tracing
      collect_logs: true          # Collect and upload logs
      log_retention_days: 7       # Log retention period
```

### Integration with Workflows

See `.github/workflows/debug-example.yml` for a complete example of integrating debugging into your workflows.

```yaml
- name: Setup logging
  run: |
    chmod +x scripts/logging.sh
    export LOG_LEVEL=0
    export VERBOSE=true

- name: Use logging
  run: |
    source scripts/logging.sh
    log_info "Starting operation"
    log_exec my-command
    log_success "Operation completed"
```

## Quick Start

### Basic Script with Logging

```bash
#!/bin/bash

# Source the logging library
source scripts/logging.sh

# Configure logging
export LOG_LEVEL=$LOG_LEVEL_INFO
export VERBOSE=false

# Use logging functions
log_info "Script started"

# Execute commands with timing
log_exec npm install
log_exec npm test

# Log success
log_success "Script completed successfully"
```

### Script with Error Handling

```bash
#!/bin/bash

source scripts/logging.sh

# Enable error trapping
setup_error_trap

# Your operations
log_info "Running operations..."

if ! log_exec risky-command; then
    log_error "Risky command failed, attempting recovery"
    log_exec fallback-command
fi

log_success "Operations completed"
```

### Script with Performance Monitoring

```bash
#!/bin/bash

source scripts/logging.sh

log_section "Performance Test"

# Monitor operation time
timer_start "build"
log_exec npm run build
duration=$(timer_stop "build")

log_info "Build took ${duration}s"
```

## Advanced Usage

### Full Debug Mode

Enable comprehensive debugging for troubleshooting:

```bash
#!/bin/bash

source scripts/logging.sh

# Enable full debug mode
setup_debug_mode  # Sets VERBOSE=true, LOG_LEVEL=0, enables tracing

# Your script continues with full debugging enabled
```

### Function Tracing

Track execution flow through your functions:

```bash
my_function() {
    log_enter "param1" "param2"
    
    log_info "Function logic here"
    
    log_exit 0
}
```

### Structured Logging for Monitoring

Generate JSON logs for integration with monitoring systems:

```bash
source scripts/logging.sh

export JSON_ONLY=true  # Output only JSON

log_json $LOG_LEVEL_INFO "deployment_started" \
    "environment" "production" \
    "version" "1.2.3" \
    "user" "$USER"

# Perform deployment

log_json $LOG_LEVEL_INFO "deployment_completed" \
    "environment" "production" \
    "version" "1.2.3" \
    "duration" "45.2"
```

### Custom Assertions

Use assertions for validation:

```bash
source scripts/logging.sh

# Assert file exists
assert "[ -f config.json ]" "Configuration file must exist"

# Assert variable is set
assert "[ -n \"\$API_KEY\" ]" "API_KEY must be set"

# Assert command succeeds
assert "curl -f https://api.example.com/health" "API must be healthy"
```

## Best Practices

### 1. Choose Appropriate Log Levels

- Use `DEBUG` for detailed diagnostic information during development
- Use `INFO` for general operational messages
- Use `WARN` for potentially problematic situations
- Use `ERROR` for failures that don't require immediate termination
- Use `FATAL` only for critical errors that prevent continuation

### 2. Enable Verbose Mode During Development

```bash
export VERBOSE=true
export LOG_LEVEL=$LOG_LEVEL_DEBUG
```

### 3. Use Structured Logging for Production

```bash
export JSON_ONLY=true
log_json $LOG_LEVEL_INFO "event" "key1" "value1" "key2" "value2"
```

### 4. Wrap Critical Operations

```bash
if ! log_exec critical-operation; then
    log_error "Critical operation failed"
    # Handle error
fi
```

### 5. Use Timers for Performance Tracking

```bash
timer_start "expensive_operation"
expensive_operation
timer_stop "expensive_operation"
```

### 6. Set Up Error Traps

```bash
setup_error_trap  # Automatically log errors with stack traces
```

### 7. Clean Up Resources

```bash
trap 'log_info "Cleaning up resources..."; cleanup' EXIT
```

## Troubleshooting

### Logs Not Appearing

**Problem**: Log messages are not showing up.

**Solution**: Check your `LOG_LEVEL` setting. Lower-level messages are filtered out:
```bash
export LOG_LEVEL=0  # Show all messages including DEBUG
```

### Colors Not Working

**Problem**: Color codes appear as text instead of colored output.

**Solution**: Ensure your terminal supports ANSI colors. Colors are automatically used for supported terminals.

### Log File Not Created

**Problem**: Logs are not being written to the file.

**Solution**: Ensure the log directory exists and is writable:
```bash
export LOG_FILE="/path/to/logs/app.log"
mkdir -p "$(dirname "$LOG_FILE")"
```

### Stack Traces Too Deep/Shallow

**Problem**: Stack traces show too many or too few frames.

**Solution**: Adjust the stack trace depth:
```bash
export STACK_TRACE_DEPTH=20  # Show more frames
```

### Script Exits on Error

**Problem**: Script exits unexpectedly when a command fails.

**Solution**: This is expected behavior with `setup_error_trap`. To handle errors gracefully:
```bash
if ! log_exec command; then
    log_warn "Command failed, continuing anyway"
fi
```

### Performance Issues

**Problem**: Logging is slowing down the script.

**Solution**: 
1. Increase `LOG_LEVEL` to reduce output
2. Disable `VERBOSE` mode
3. Avoid logging in tight loops

### GitHub Actions Logs Not Uploaded

**Problem**: Debug logs are not being uploaded as artifacts.

**Solution**: Ensure the `collect_logs` input is set to `true`:
```yaml
uses: ./.github/workflows/reusable-debug.yml
with:
  collect_logs: true
```

## Examples

See `scripts/logging_example.sh` for a comprehensive demonstration of all logging features.

Run the example:
```bash
chmod +x scripts/logging_example.sh
./scripts/logging_example.sh
```

## Support

For issues or questions about the logging and debugging system:

1. Check this documentation
2. Review the example scripts
3. Examine the GitHub Actions workflow logs
4. Open an issue in the repository

## License

This logging and debugging system is part of the Cloud Service Management System.
