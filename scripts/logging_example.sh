#!/bin/bash

###############################################################################
# Example script demonstrating the logging and debugging library
###############################################################################

# Source the logging library
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/logging.sh"

# Example 1: Basic Logging
example_basic_logging() {
    log_enter
    
    log_section "Example 1: Basic Logging Levels"
    
    log_debug "This is a debug message (only shown when LOG_LEVEL=0)"
    log_info "This is an informational message"
    log_warn "This is a warning message"
    log_error "This is an error message (goes to stderr)"
    log_success "Operation completed successfully!"
    
    log_exit
}

# Example 2: Verbose Mode
example_verbose_mode() {
    log_enter
    
    log_section "Example 2: Verbose Mode with Caller Information"
    
    # Enable verbose mode
    VERBOSE=true
    
    log_debug "Debug message with caller info"
    log_info "Info message with caller info"
    
    # Disable verbose mode
    VERBOSE=false
    
    log_exit
}

# Example 3: Command Execution with Timing
example_command_execution() {
    log_enter
    
    log_section "Example 3: Command Execution with Timing"
    
    log_exec echo "Hello, World!"
    log_exec sleep 1
    log_exec ls -la "$SCRIPT_DIR"
    
    log_exit
}

# Example 4: Variable Dumping
example_variable_dumping() {
    log_enter
    
    log_section "Example 4: Variable Dumping for Debugging"
    
    local TEST_VAR1="value1"
    local TEST_VAR2="value2"
    local TEST_VAR3="value3"
    
    log_vars TEST_VAR1 TEST_VAR2 TEST_VAR3
    
    log_exit
}

# Example 5: Performance Monitoring
example_performance_monitoring() {
    log_enter
    
    log_section "Example 5: Performance Monitoring with Timers"
    
    timer_start "operation1"
    sleep 0.5
    timer_stop "operation1"
    
    timer_start "operation2"
    sleep 1
    timer_stop "operation2"
    
    log_exit
}

# Example 6: Error Handling with Stack Traces
example_error_handling() {
    log_enter
    
    log_section "Example 6: Error Handling with Stack Traces"
    
    # Set up error trap
    setup_error_trap
    
    # This function will fail and log stack trace
    failing_function() {
        log_debug "Attempting to run a failing command..."
        # Uncomment the next line to see error handling in action
        # false
        log_info "Command would fail here (commented out for demo)"
    }
    
    failing_function
    
    log_exit
}

# Example 7: Assertions
example_assertions() {
    log_enter
    
    log_section "Example 7: Assertions for Testing"
    
    local value=42
    
    assert "[ $value -eq 42 ]" "Value should be 42"
    assert "[ -f '$SCRIPT_DIR/logging.sh' ]" "Logging library should exist"
    
    log_success "All assertions passed!"
    
    log_exit
}

# Example 8: Structured JSON Logging
example_json_logging() {
    log_enter
    
    log_section "Example 8: Structured JSON Logging"
    
    log_json $LOG_LEVEL_INFO "User logged in" "user_id" "12345" "ip_address" "192.168.1.1"
    log_json $LOG_LEVEL_WARN "High memory usage" "memory_percent" "85" "threshold" "80"
    log_json $LOG_LEVEL_ERROR "Database connection failed" "database" "prod-db" "retry_count" "3"
    
    log_exit
}

# Example 9: Log Levels
example_log_levels() {
    log_enter
    
    log_section "Example 9: Different Log Levels"
    
    log_info "Current log level: $LOG_LEVEL"
    
    # Test with different log levels
    export LOG_LEVEL=$LOG_LEVEL_DEBUG
    log_info "Set log level to DEBUG ($LOG_LEVEL_DEBUG)"
    log_debug "Debug message is now visible"
    
    export LOG_LEVEL=$LOG_LEVEL_WARN
    log_info "Set log level to WARN ($LOG_LEVEL_WARN)"
    log_debug "Debug message is now hidden"
    log_info "Info message is now hidden"
    log_warn "Warning message is visible"
    
    # Reset to INFO
    export LOG_LEVEL=$LOG_LEVEL_INFO
    
    log_exit
}

# Example 10: Function Tracing
example_function_tracing() {
    log_enter "param1" "param2"
    
    log_section "Example 10: Function Entry/Exit Tracing"
    
    nested_function() {
        log_enter "nested_param"
        log_info "Inside nested function"
        log_exit 0
    }
    
    nested_function
    
    log_exit 0
}

# Main execution
main() {
    log_section "Cloud Service Management System - Logging Library Demo"
    
    log_info "Starting demonstration of logging and debugging features"
    log_info ""
    
    # Run examples
    example_basic_logging
    example_verbose_mode
    example_command_execution
    example_variable_dumping
    example_performance_monitoring
    example_error_handling
    example_assertions
    example_json_logging
    example_log_levels
    example_function_tracing
    
    log_section "Demo Complete"
    log_success "All examples completed successfully!"
    log_info ""
    log_info "To use the logging library in your scripts:"
    log_info "  1. Source it: source /path/to/logging.sh"
    log_info "  2. Set LOG_LEVEL environment variable (optional): export LOG_LEVEL=0"
    log_info "  3. Enable verbose mode (optional): export VERBOSE=true"
    log_info "  4. Use logging functions: log_info, log_debug, log_error, etc."
}

# Run main function
main "$@"
