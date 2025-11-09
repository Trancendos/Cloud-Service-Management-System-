#!/bin/bash

###############################################################################
# Test Data Validation Script
# Validates JSON files in the test-data/ directory
###############################################################################

# Enable nullglob to handle empty glob patterns properly
# Without this, if no .json files exist, the glob pattern will literally
# be the string 'test-data/*.json' instead of expanding to nothing
shopt -s nullglob

# Source logging library for consistent output
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [ -f "$SCRIPT_DIR/logging.sh" ]; then
    source "$SCRIPT_DIR/logging.sh"
else
    # Fallback to basic echo if logging library not available
    log_info() { echo "[INFO] $*"; }
    log_error() { echo "[ERROR] $*" >&2; }
    log_success() { echo "[SUCCESS] $*"; }
    log_warn() { echo "[WARN] $*"; }
fi

# Initialize counters
TOTAL_FILES=0
VALID_FILES=0
INVALID_FILES=0

log_info "Starting test data validation..."
log_info "Scanning test-data/ directory for JSON files..."

# Process all JSON files in test-data/ directory
# With nullglob enabled, this will expand to nothing if no files exist
for file in test-data/*.json; do
    # With nullglob, if no files match, the loop won't execute
    # Without nullglob, we'd need this check:
    # if [ -f "$file" ]; then
    
    ((TOTAL_FILES++))
    log_info "Validating: $file"
    
    # Validate JSON syntax
    if jq empty "$file" >/dev/null 2>&1; then
        log_success "  ✓ Valid JSON syntax"
        ((VALID_FILES++))
        
        # Additional validation: check for required structure
        if jq -e 'type == "object" or type == "array"' "$file" >/dev/null 2>&1; then
            log_info "  ✓ Valid JSON structure (object or array)"
        else
            log_warn "  ⚠ JSON is valid but not an object or array"
        fi
    else
        log_error "  ✗ Invalid JSON syntax"
        ((INVALID_FILES++))
    fi
done

# Report summary
log_info ""
log_info "=========================================="
log_info "Validation Summary"
log_info "=========================================="
log_info "Total files processed: $TOTAL_FILES"
log_info "Valid files: $VALID_FILES"
log_info "Invalid files: $INVALID_FILES"

if [ $TOTAL_FILES -eq 0 ]; then
    log_warn "No JSON files found in test-data/ directory"
    exit 0
elif [ $INVALID_FILES -gt 0 ]; then
    log_error "Validation failed: $INVALID_FILES file(s) have errors"
    exit 1
else
    log_success "All JSON files are valid!"
    exit 0
fi
