#!/bin/bash
# Validation script for multi-cloud CI/CD configurations
# This script checks that all configuration files are valid and properly structured

echo "==================================================================="
echo "Multi-Cloud CI/CD Configuration Validator"
echo "==================================================================="
echo ""

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Counter for results
PASSED=0
FAILED=0
WARNINGS=0

# Function to check if a file exists
check_file() {
    local file=$1
    local description=$2
    
    echo -n "Checking $description... "
    if [ -f "$file" ]; then
        echo -e "${GREEN}✓ Found${NC}"
        ((PASSED++))
        return 0
    else
        echo -e "${RED}✗ Missing${NC}"
        ((FAILED++))
        return 1
    fi
}

# Function to validate YAML syntax
validate_yaml() {
    local file=$1
    local description=$2
    
    echo -n "Validating $description YAML syntax... "
    
    if ! command -v yamllint &> /dev/null; then
        echo -e "${YELLOW}⚠ yamllint not installed, skipping syntax check${NC}"
        ((WARNINGS++))
        return 0
    fi

    # Using relaxed mode to allow common style variations across different
    # CI/CD platforms (e.g., document-start markers, line length)
    # This ensures compatibility while still catching syntax errors
    if yamllint -d relaxed "$file" > /dev/null 2>&1; then
        echo -e "${GREEN}✓ Valid${NC}"
        ((PASSED++))
        return 0
    else
        echo -e "${RED}✗ Invalid${NC}"
        yamllint -d relaxed "$file" 2>&1 | head -5
        ((FAILED++))
        return 1
    fi
}

# Function to check for required content
check_content() {
    local file=$1
    local pattern=$2
    local description=$3
    
    echo -n "Checking $description... "
    if grep -q "$pattern" "$file"; then
        echo -e "${GREEN}✓ Found${NC}"
        ((PASSED++))
        return 0
    else
        echo -e "${YELLOW}⚠ Not found${NC}"
        ((WARNINGS++))
        return 1
    fi
}

echo "1. Checking GitHub Actions Configuration"
echo "-------------------------------------------------------------------"
check_file ".github/workflows/example-ci.yml" "GitHub Actions workflow"
if [ $? -eq 0 ]; then
    validate_yaml ".github/workflows/example-ci.yml" "GitHub Actions"
    check_content ".github/workflows/example-ci.yml" "actions/checkout" "Checkout action"
    check_content ".github/workflows/example-ci.yml" "actions/cache" "Cache action"
fi
echo ""

echo "2. Checking Azure DevOps Pipelines Configuration"
echo "-------------------------------------------------------------------"
check_file ".azure-pipelines/azure-pipelines.yml" "Azure Pipelines config"
if [ $? -eq 0 ]; then
    validate_yaml ".azure-pipelines/azure-pipelines.yml" "Azure Pipelines"
    check_content ".azure-pipelines/azure-pipelines.yml" "trigger:" "Trigger configuration"
    check_content ".azure-pipelines/azure-pipelines.yml" "Cache@2" "Cache task"
fi
check_file ".azure-pipelines/README.md" "Azure Pipelines documentation"
echo ""

echo "3. Checking Google Cloud Build Configuration"
echo "-------------------------------------------------------------------"
check_file ".google-cloud/cloudbuild.yaml" "Google Cloud Build config"
if [ $? -eq 0 ]; then
    validate_yaml ".google-cloud/cloudbuild.yaml" "Google Cloud Build"
    check_content ".google-cloud/cloudbuild.yaml" "steps:" "Build steps"
    check_content ".google-cloud/cloudbuild.yaml" "node:" "Node.js image"
fi
check_file ".google-cloud/README.md" "Google Cloud Build documentation"
echo ""

echo "4. Checking AWS CodeBuild Configuration"
echo "-------------------------------------------------------------------"
check_file ".aws/buildspec.yml" "AWS CodeBuild buildspec"
if [ $? -eq 0 ]; then
    validate_yaml ".aws/buildspec.yml" "AWS CodeBuild"
    check_content ".aws/buildspec.yml" "version:" "Buildspec version"
    check_content ".aws/buildspec.yml" "phases:" "Build phases"
    check_content ".aws/buildspec.yml" "cache:" "Cache configuration"
fi
check_file ".aws/README.md" "AWS CodeBuild documentation"
echo ""

echo "5. Checking GitLab CI/CD Configuration"
echo "-------------------------------------------------------------------"
check_file ".gitlab/.gitlab-ci.yml" "GitLab CI/CD config"
if [ $? -eq 0 ]; then
    validate_yaml ".gitlab/.gitlab-ci.yml" "GitLab CI/CD"
    check_content ".gitlab/.gitlab-ci.yml" "stages:" "Pipeline stages"
    check_content ".gitlab/.gitlab-ci.yml" "cache:" "Cache configuration"
fi
check_file ".gitlab/README.md" "GitLab CI/CD documentation"
echo ""

echo "6. Checking CircleCI Configuration"
echo "-------------------------------------------------------------------"
check_file ".circleci/config.yml" "CircleCI config"
if [ $? -eq 0 ]; then
    validate_yaml ".circleci/config.yml" "CircleCI"
    check_content ".circleci/config.yml" "version:" "Config version"
    check_content ".circleci/config.yml" "workflows:" "Workflow definition"
fi
check_file ".circleci/README.md" "CircleCI documentation"
echo ""

echo "7. Checking Documentation"
echo "-------------------------------------------------------------------"
check_file "MULTI_CLOUD_CI_CD.md" "Multi-cloud guide"
check_file "README.md" "Main README"
if [ -f "README.md" ]; then
    check_content "README.md" "Multi-Cloud" "Multi-cloud section"
fi
echo ""

echo "==================================================================="
echo "Validation Summary"
echo "==================================================================="
echo -e "${GREEN}Passed:${NC} $PASSED"
echo -e "${RED}Failed:${NC} $FAILED"
echo -e "${YELLOW}Warnings:${NC} $WARNINGS"
echo ""

if [ $FAILED -eq 0 ]; then
    echo -e "${GREEN}✓ All critical checks passed!${NC}"
    echo ""
    echo "Your multi-cloud CI/CD configurations are ready to use."
    echo "Check the platform-specific README files for setup instructions."
    exit 0
else
    echo -e "${RED}✗ Some checks failed.${NC}"
    echo ""
    echo "Please fix the issues above before using the configurations."
    exit 1
fi
