# Scripts Directory

This directory contains utility scripts for the Cloud Service Management System.

## Available Scripts

### logging.sh

Comprehensive logging and debugging library for shell scripts.

**Purpose**: Provides a complete logging framework with multiple log levels, performance monitoring, error handling, and structured logging capabilities.

**Usage**:
```bash
source scripts/logging.sh

log_info "Your message here"
log_exec command args
timer_start "operation"
# ... your code ...
timer_stop "operation"
```

**Features**:
- Multiple log levels (DEBUG, INFO, WARN, ERROR, FATAL)
- Colored output for better readability
- Stack traces for error debugging
- Performance monitoring with timers
- Function entry/exit tracing
- Structured JSON logging
- Automatic error handling with traps
- Variable and environment dumping

**Configuration**:
- `LOG_LEVEL`: Set logging verbosity (0=DEBUG, 1=INFO, 2=WARN, 3=ERROR, 4=FATAL)
- `VERBOSE`: Enable verbose mode with caller information (true/false)
- `LOG_FILE`: Optional file path to write logs
- `STACK_TRACE_DEPTH`: Number of stack frames to display (default: 10)

See [Debugging and Logging Guide](../docs/DEBUGGING_AND_LOGGING.md) for detailed documentation.

### logging_example.sh

Example script demonstrating all features of the logging library.

**Purpose**: Comprehensive demonstration of logging capabilities including basic logging, command execution, performance monitoring, error handling, assertions, and more.

**Usage**:
```bash
chmod +x scripts/logging_example.sh
./scripts/logging_example.sh
```

**What it demonstrates**:
1. Basic logging levels
2. Verbose mode with caller information
3. Command execution with timing
4. Variable dumping for debugging
5. Performance monitoring with timers
6. Error handling with stack traces
7. Assertions for testing
8. Structured JSON logging
9. Different log level filtering
10. Function entry/exit tracing

## Integration with GitHub Actions

These scripts are designed to work seamlessly with GitHub Actions workflows. See the example workflows:

- `.github/workflows/reusable-debug.yml`: Reusable debugging workflow
- `.github/workflows/debug-example.yml`: Example implementation

## Best Practices

1. **Source the library**: Always source `logging.sh` at the beginning of your scripts
2. **Set log level**: Configure `LOG_LEVEL` based on your needs (use DEBUG for development)
3. **Use appropriate functions**: Choose the right log level for each message
4. **Wrap commands**: Use `log_exec` to execute commands with automatic timing
5. **Handle errors**: Set up error traps with `setup_error_trap` for automatic error logging
6. **Monitor performance**: Use timers for operations that need performance tracking

## Examples

### Basic Script
```bash
#!/bin/bash
source scripts/logging.sh

log_info "Starting deployment..."
log_exec ./deploy.sh
log_success "Deployment completed!"
```

### Script with Error Handling
```bash
#!/bin/bash
source scripts/logging.sh
setup_error_trap

log_info "Running tests..."
if ! log_exec npm test; then
    log_error "Tests failed"
    exit 1
fi
log_success "All tests passed!"
```

### Script with Performance Monitoring
```bash
#!/bin/bash
source scripts/logging.sh

timer_start "build"
log_exec npm run build
duration=$(timer_stop "build")

log_info "Build completed in ${duration}s"
```

## Contributing

When adding new scripts:

1. Follow the existing naming conventions
2. Add comprehensive comments and documentation
3. Include usage examples
4. Update this README
5. Ensure scripts are executable (`chmod +x`)
6. Test thoroughly before committing

## Support

For questions or issues with these scripts, refer to:
- [Debugging and Logging Guide](../docs/DEBUGGING_AND_LOGGING.md)
- GitHub Issues
- Repository maintainers
