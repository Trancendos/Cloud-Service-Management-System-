#!/bin/bash
# AI Data Validation Script
# Validates JSON and YAML data files in the repository

set -e

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Counters
VALID_FILES=0
INVALID_FILES=0
WARNINGS=0
TOTAL_FILES=0

# Arrays to store file lists
VALID_FILE_LIST=()
INVALID_FILE_LIST=()
WARNING_FILE_LIST=()

echo "🤖 AI Data Validation Report"
echo "================================"
echo ""

# Function to validate JSON files
validate_json() {
    local file=$1
    echo -n "Validating JSON: $file ... "
    
    if jq empty "$file" 2>/dev/null; then
        echo -e "${GREEN}✅ Valid${NC}"
        VALID_FILES=$((VALID_FILES + 1))
        VALID_FILE_LIST+=("$file")
        return 0
    else
        echo -e "${RED}❌ Invalid${NC}"
        INVALID_FILES=$((INVALID_FILES + 1))
        INVALID_FILE_LIST+=("$file")
        return 1
    fi
}

# Function to validate YAML files
validate_yaml() {
    local file=$1
    echo -n "Validating YAML: $file ... "
    
    # Try python with PyYAML first
    if command -v python3 &> /dev/null; then
        if python3 -c "import yaml, sys; yaml.safe_load(open(sys.argv[1]))" "$file" 2>/dev/null; then
            echo -e "${GREEN}✅ Valid${NC}"
            VALID_FILES=$((VALID_FILES + 1))
            VALID_FILE_LIST+=("$file")
            return 0
        else
            echo -e "${RED}❌ Invalid${NC}"
            INVALID_FILES=$((INVALID_FILES + 1))
            INVALID_FILE_LIST+=("$file")
            return 1
        fi
    # Fallback to yamllint if available
    elif command -v yamllint &> /dev/null; then
        if yamllint -d relaxed "$file" > /dev/null 2>&1; then
            echo -e "${GREEN}✅ Valid${NC}"
            VALID_FILES=$((VALID_FILES + 1))
            VALID_FILE_LIST+=("$file")
            return 0
        else
            echo -e "${RED}❌ Invalid${NC}"
            INVALID_FILES=$((INVALID_FILES + 1))
            INVALID_FILE_LIST+=("$file")
            return 1
        fi
    else
        # No validation tool available - issue warning
        echo -e "${YELLOW}⚠️ Warning: No YAML validator available${NC}"
        WARNINGS=$((WARNINGS + 1))
        WARNING_FILE_LIST+=("$file")
        return 2
    fi
}

# Main validation logic
echo "🔍 Scanning for data files..."
echo ""

# Validate JSON files in test-data
if [ -d "test-data" ]; then
    echo "📁 Validating test-data/ JSON files"
    echo "-----------------------------------"
    for file in test-data/*.json; do
        if [ -f "$file" ]; then
            TOTAL_FILES=$((TOTAL_FILES + 1))
            validate_json "$file"
        fi
    done
    echo ""
fi

# Validate key configuration files (one per platform)
echo "📁 Validating platform configuration files"
echo "-----------------------------------"
KEY_CONFIGS=(
    ".azure-pipelines/azure-pipelines.yml"
    ".google-cloud/cloudbuild.yaml"
    ".aws/buildspec.yml"
    ".gitlab/.gitlab-ci.yml"
    ".circleci/config.yml"
)

for file in "${KEY_CONFIGS[@]}"; do
    if [ -f "$file" ]; then
        TOTAL_FILES=$((TOTAL_FILES + 1))
        validate_yaml "$file"
    fi
done
echo ""

# Summary
echo "================================"
echo "📊 Validation Summary"
echo "================================"
echo -e "${GREEN}✅ Valid Files:${NC} $VALID_FILES"
echo -e "${RED}❌ Invalid Files:${NC} $INVALID_FILES"
echo -e "${YELLOW}⚠️ Warnings:${NC} $WARNINGS"
echo ""
echo "Total files scanned: $TOTAL_FILES"
echo ""

# Export results for GitHub Actions
if [ -n "$GITHUB_OUTPUT" ]; then
    echo "valid_files=$VALID_FILES" >> "$GITHUB_OUTPUT"
    echo "invalid_files=$INVALID_FILES" >> "$GITHUB_OUTPUT"
    echo "warnings=$WARNINGS" >> "$GITHUB_OUTPUT"
    echo "total_files=$TOTAL_FILES" >> "$GITHUB_OUTPUT"
fi

# Exit with error if there are invalid files
if [ $INVALID_FILES -gt 0 ]; then
    echo -e "${RED}❌ Validation failed: $INVALID_FILES invalid file(s)${NC}"
    exit 1
else
    echo -e "${GREEN}✅ All data files passed validation!${NC}"
    exit 0
fi
