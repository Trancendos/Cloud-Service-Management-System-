#!/bin/bash

###############################################################################
# Cloud Service Management System - Logging and Debugging Library
# Provides comprehensive logging, debugging, and error reporting functions
###############################################################################

# Color codes for output
export LOG_COLOR_RESET='\033[0m'
export LOG_COLOR_RED='\033[0;31m'
export LOG_COLOR_GREEN='\033[0;32m'
export LOG_COLOR_YELLOW='\033[0;33m'
export LOG_COLOR_BLUE='\033[0;34m'
export LOG_COLOR_MAGENTA='\033[0;35m'
export LOG_COLOR_CYAN='\033[0;36m'
export LOG_COLOR_WHITE='\033[0;37m'
export LOG_COLOR_BOLD='\033[1m'

# Log levels
export LOG_LEVEL_DEBUG=0
export LOG_LEVEL_INFO=1
export LOG_LEVEL_WARN=2
export LOG_LEVEL_ERROR=3
export LOG_LEVEL_FATAL=4

# Default log level (can be overridden by LOG_LEVEL environment variable)
: ${LOG_LEVEL:=$LOG_LEVEL_INFO}

# Verbose mode flag (set via VERBOSE environment variable)
: ${VERBOSE:=false}

# Log file location (optional - logs to stdout by default)
: ${LOG_FILE:=""}

# Stack trace depth for debugging
: ${STACK_TRACE_DEPTH:=10}

###############################################################################
# Internal Helper Functions
###############################################################################

# Calculate duration between two timestamps (portable, no bc required)
_calc_duration() {
    local start_time="$1"
    local end_time="$2"

    # Try to use bc if available for precise calculation
    if command -v bc >/dev/null 2>&1; then
        echo "$end_time - $start_time" | bc -l
    else
        # Fallback to integer arithmetic (seconds only)
        local start_sec="${start_time%.*}"
        local end_sec="${end_time%.*}"
        echo "$((end_sec - start_sec))"
    fi
}

# Get current timestamp in ISO 8601 format
_log_timestamp() {
    # Use portable date format (milliseconds not supported on all systems)
    if date -u +"%Y-%m-%dT%H:%M:%S.%3NZ" 2>/dev/null | grep -q '%3N'; then
        # Fallback for systems without %N support (e.g., macOS)
        date -u +"%Y-%m-%dT%H:%M:%SZ"
    else
        date -u +"%Y-%m-%dT%H:%M:%S.%3NZ"
    fi
}

# Get log level name
_log_level_name() {
    case $1 in
        $LOG_LEVEL_DEBUG) echo "DEBUG" ;;
        $LOG_LEVEL_INFO)  echo "INFO " ;;
        $LOG_LEVEL_WARN)  echo "WARN " ;;
        $LOG_LEVEL_ERROR) echo "ERROR" ;;
        $LOG_LEVEL_FATAL) echo "FATAL" ;;
        *) echo "UNKNOWN" ;;
    esac
}

# Get color for log level
_log_level_color() {
    case $1 in
        $LOG_LEVEL_DEBUG) echo "$LOG_COLOR_CYAN" ;;
        $LOG_LEVEL_INFO)  echo "$LOG_COLOR_GREEN" ;;
        $LOG_LEVEL_WARN)  echo "$LOG_COLOR_YELLOW" ;;
        $LOG_LEVEL_ERROR) echo "$LOG_COLOR_RED" ;;
        $LOG_LEVEL_FATAL) echo "$LOG_COLOR_MAGENTA" ;;
        *) echo "$LOG_COLOR_WHITE" ;;
    esac
}

# Core logging function
_log() {
    local level=$1
    shift
    local message="$*"
    
    # Check if we should log based on current log level
    if [ "$level" -lt "$LOG_LEVEL" ]; then
        return 0
    fi
    
    local timestamp=$(_log_timestamp)
    local level_name=$(_log_level_name "$level")
    local color=$(_log_level_color "$level")
    
    # Get caller information for debugging
    local caller_info=""
    if [ "$VERBOSE" = "true" ] || [ "$level" -ge "$LOG_LEVEL_ERROR" ]; then
        caller_info=" [${BASH_SOURCE[2]##*/}:${BASH_LINENO[1]}:${FUNCNAME[2]:-main}]"
    fi
    
    # Format log message
    local log_message="[$timestamp] [$level_name]$caller_info $message"
    
    # Output with color to stderr (or stdout for INFO/DEBUG)
    if [ "$level" -ge "$LOG_LEVEL_ERROR" ]; then
        echo -e "${color}${log_message}${LOG_COLOR_RESET}" >&2
    else
        echo -e "${color}${log_message}${LOG_COLOR_RESET}"
    fi
    
    # Also write to log file if specified
    if [ -n "$LOG_FILE" ]; then
        echo "$log_message" >> "$LOG_FILE"
    fi
    
    # Exit on FATAL
    if [ "$level" -eq "$LOG_LEVEL_FATAL" ]; then
        log_stack_trace
        exit 1
    fi
}

###############################################################################
# Public Logging Functions
###############################################################################

# Log debug message
log_debug() {
    _log $LOG_LEVEL_DEBUG "$@"
}

# Log info message
log_info() {
    _log $LOG_LEVEL_INFO "$@"
}

# Log warning message
log_warn() {
    _log $LOG_LEVEL_WARN "$@"
}

# Log error message
log_error() {
    _log $LOG_LEVEL_ERROR "$@"
}

# Log fatal error and exit
log_fatal() {
    _log $LOG_LEVEL_FATAL "$@"
}

# Log success message (special info with green checkmark)
log_success() {
    local message="$*"
    _log $LOG_LEVEL_INFO "✅ $message"
}

# Log failure message (special error with red X)
log_failure() {
    local message="$*"
    _log $LOG_LEVEL_ERROR "❌ $message"
}

# Log section header
log_section() {
    local message="$*"
    echo ""
    _log $LOG_LEVEL_INFO "${LOG_COLOR_BOLD}========================================${LOG_COLOR_RESET}"
    _log $LOG_LEVEL_INFO "${LOG_COLOR_BOLD}$message${LOG_COLOR_RESET}"
    _log $LOG_LEVEL_INFO "${LOG_COLOR_BOLD}========================================${LOG_COLOR_RESET}"
}

###############################################################################
# Debugging Functions
###############################################################################

# Print stack trace
log_stack_trace() {
    log_error "Stack trace:"
    local frame=0
    while [ $frame -lt ${STACK_TRACE_DEPTH} ]; do
        local line_no=${BASH_LINENO[$frame]}
        local func_name=${FUNCNAME[$((frame + 1))]}
        local source_file=${BASH_SOURCE[$((frame + 1))]}
        
        if [ -z "$source_file" ]; then
            break
        fi
        
        log_error "  #$frame: $func_name() at $source_file:$line_no"
        ((frame++))
    done
}

# Dump all environment variables (for debugging)
log_env_vars() {
    log_debug "Environment variables:"
    while IFS='=' read -r name value; do
        log_debug "  $name=$value"
    done < <(env | sort)
}

# Dump specific variables
log_vars() {
    log_debug "Variables:"
    for var_name in "$@"; do
        local var_value="${!var_name}"
        log_debug "  $var_name=$var_value"
    done
}

# Log command execution with timing
log_exec() {
    local cmd="$*"
    log_debug "Executing: $cmd"
    
    local start_time=$(date +%s.%N)
    
    # Execute command and capture exit code
    local output
    local exit_code
    
    if [ "$VERBOSE" = "true" ]; then
        # Show output in verbose mode
        "$@"
        exit_code=$?
    else
        # Capture output in non-verbose mode
        output=$("$@" 2>&1)
        exit_code=$?
    fi

    local end_time=$(date +%s.%N)
    local duration=$(_calc_duration "$start_time" "$end_time")
    local duration_fmt=$(printf "%.3f" "$duration" 2>/dev/null || echo "$duration")

    if [ $exit_code -eq 0 ]; then
        log_debug "Command completed successfully in ${duration_fmt}s"
        if [ "$VERBOSE" = "false" ] && [ -n "$output" ]; then
            log_debug "Output: $output"
        fi
    else
        log_error "Command failed with exit code $exit_code in ${duration_fmt}s"
        if [ -n "$output" ]; then
            log_error "Output: $output"
        fi
        return $exit_code
    fi
    
    return 0
}

# Log function entry (for tracing)
log_enter() {
    local func_name="${FUNCNAME[1]}"
    local args="$*"
    log_debug "→ Entering $func_name($args)"
}

# Log function exit (for tracing)
log_exit() {
    local func_name="${FUNCNAME[1]}"
    local exit_code=${1:-$?}
    log_debug "← Exiting $func_name (exit code: $exit_code)"
    return $exit_code
}

###############################################################################
# Error Handling Functions
###############################################################################

# Set up error trap for automatic logging
setup_error_trap() {
    set -E  # Inherit ERR trap
    trap 'log_error "Command failed at line $LINENO: $BASH_COMMAND"; log_stack_trace' ERR
}

# Set up exit trap
setup_exit_trap() {
    trap 'log_debug "Script exiting with code $?"' EXIT
}

# Set up comprehensive debugging
setup_debug_mode() {
    export VERBOSE=true
    export LOG_LEVEL=$LOG_LEVEL_DEBUG
    set -x  # Enable command tracing
    setup_error_trap
    setup_exit_trap
    log_info "Debug mode enabled"
}

# Assert function for testing conditions
assert() {
    local condition="$1"
    local message="${2:-Assertion failed}"
    
    if ! eval "$condition"; then
        log_fatal "Assertion failed: $message (condition: $condition)"
    fi
    
    log_debug "Assertion passed: $condition"
}

# Check if command exists
require_command() {
    local cmd="$1"
    local message="${2:-Required command not found: $cmd}"
    
    if ! command -v "$cmd" &> /dev/null; then
        log_fatal "$message"
    fi
    
    log_debug "Required command found: $cmd"
}

###############################################################################
# Performance Monitoring Functions
###############################################################################

# Start a timer
timer_start() {
    local timer_name="${1:-default}"
    eval "TIMER_${timer_name}=$(date +%s.%N)"
    log_debug "Timer '$timer_name' started"
}

# Stop a timer and log duration
timer_stop() {
    local timer_name="${1:-default}"
    local start_time_var="TIMER_${timer_name}"
    local start_time="${!start_time_var}"
    
    if [ -z "$start_time" ]; then
        log_warn "Timer '$timer_name' was not started"
        return 1
    fi

    local end_time=$(date +%s.%N)
    local duration=$(_calc_duration "$start_time" "$end_time")
    local duration_fmt=$(printf "%.3f" "$duration" 2>/dev/null || echo "$duration")

    log_info "Timer '$timer_name' completed in ${duration_fmt}s"

    # Clean up timer variable
    unset "TIMER_${timer_name}"

    echo "$duration_fmt"
}

###############################################################################
# Structured Logging Functions
###############################################################################

# Log in JSON format (useful for log aggregation systems)
log_json() {
    local level="$1"
    local message="$2"
    shift 2
    
    local timestamp=$(_log_timestamp)
    local level_name=$(_log_level_name "$level")
    
    # Build JSON object with additional fields
    local json="{\"timestamp\":\"$timestamp\",\"level\":\"$level_name\",\"message\":\"$message\""
    
    # Add additional key-value pairs
    while [ $# -gt 0 ]; do
        local key="$1"
        local value="$2"
        json="$json,\"$key\":\"$value\""
        shift 2
    done
    
    json="$json}"
    
    echo "$json"
    
    # Also log normally if not in JSON-only mode
    if [ "${JSON_ONLY:-false}" != "true" ]; then
        _log "$level" "$message"
    fi
}

###############################################################################
# Initialization
###############################################################################

# Log library initialization
_init_logging() {
    # Create log directory if LOG_FILE is specified
    if [ -n "$LOG_FILE" ]; then
        local log_dir=$(dirname "$LOG_FILE")
        mkdir -p "$log_dir" 2>/dev/null || true
    fi
    
    # Log initialization
    log_debug "Logging library initialized (LOG_LEVEL=$LOG_LEVEL, VERBOSE=$VERBOSE)"
}

# Auto-initialize when sourced
_init_logging
