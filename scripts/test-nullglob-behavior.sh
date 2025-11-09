#!/bin/bash

###############################################################################
# Test script to demonstrate the importance of nullglob
# This script shows what happens WITHOUT nullglob enabled
###############################################################################

echo "==================================================================="
echo "Testing glob behavior WITHOUT nullglob"
echo "==================================================================="
echo ""

# Create a temporary test directory
TEST_DIR="/tmp/nullglob-test"
rm -rf "$TEST_DIR"
mkdir -p "$TEST_DIR"

echo "Test 1: With JSON files present"
echo "-------------------------------------------------------------------"
# Create some test files
echo '{"test": 1}' > "$TEST_DIR/file1.json"
echo '{"test": 2}' > "$TEST_DIR/file2.json"

# WITHOUT nullglob
echo "Without nullglob (default behavior):"
for file in "$TEST_DIR"/*.json; do
    if [ -f "$file" ]; then
        echo "  Processing: $file"
    fi
done

echo ""
echo "Test 2: Without JSON files (the problem case)"
echo "-------------------------------------------------------------------"
# Remove all JSON files
rm -f "$TEST_DIR"/*.json

echo "Without nullglob (default behavior):"
for file in "$TEST_DIR"/*.json; do
    echo "  Loop iteration with: $file"
    if [ -f "$file" ]; then
        echo "    File exists, processing..."
    else
        echo "    File does NOT exist (glob didn't expand!)"
        echo "    \$file is literally the string: $file"
    fi
done

echo ""
echo "==================================================================="
echo "Testing glob behavior WITH nullglob"
echo "==================================================================="
echo ""

# Enable nullglob
shopt -s nullglob

echo "Test 3: With JSON files present"
echo "-------------------------------------------------------------------"
# Create test files again
echo '{"test": 1}' > "$TEST_DIR/file1.json"
echo '{"test": 2}' > "$TEST_DIR/file2.json"

echo "With nullglob enabled:"
for file in "$TEST_DIR"/*.json; do
    echo "  Processing: $file"
done

echo ""
echo "Test 4: Without JSON files (the fixed behavior)"
echo "-------------------------------------------------------------------"
# Remove all JSON files
rm -f "$TEST_DIR"/*.json

echo "With nullglob enabled:"
FILE_COUNT=0
for file in "$TEST_DIR"/*.json; do
    ((FILE_COUNT++))
    echo "  Processing: $file"
done

if [ $FILE_COUNT -eq 0 ]; then
    echo "  (Loop did not execute - glob expanded to nothing)"
    echo "  This is the CORRECT behavior!"
fi

echo ""
echo "==================================================================="
echo "Summary"
echo "==================================================================="
echo "WITHOUT nullglob: When no files match, the glob pattern itself"
echo "                  becomes the loop variable (e.g., 'test-data/*.json')"
echo "                  You must use '[ -f \"\$file\" ]' to avoid errors"
echo ""
echo "WITH nullglob:    When no files match, the loop doesn't execute"
echo "                  This is cleaner and prevents unexpected behavior"
echo "==================================================================="

# Cleanup
rm -rf "$TEST_DIR"
