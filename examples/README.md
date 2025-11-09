# AI Bot Integration Examples

This directory contains example files for testing and demonstrating the AI/bot integration capabilities.

## Example Files

### 1. config.json
Example JSON configuration file that demonstrates:
- Valid JSON syntax
- Proper structure
- Best practices for configuration files

The AI Data Checker will validate this file automatically on pull requests.

### 2. sample-workflow.yml
Example GitHub Actions workflow that demonstrates:
- Modern action versions
- Proper security practices
- Performance optimizations

The AI Workflow Validator will check this file for best practices.

## Testing AI Bots

To test the AI bot capabilities:

1. **Make a change** to any example file
2. **Create a pull request**
3. **Observe** the AI bot comments and analysis
4. **Review** the workflow run logs for detailed reports

## AI Bot Triggers

Different AI bots will trigger based on the files you modify:

- **JSON/YAML/Markdown files** → AI Data Checker
- **Workflow files** → AI Workflow Validator
- **Any code files** → AI Code Review Bot
- **Workflow failures** → AI Debugging Assistant

## Example Test Cases

### Test Case 1: Valid Data File
Modify `config.json` with valid changes:
- Update version number
- Add new configuration option
- Expected: ✅ Validation passes

### Test Case 2: Invalid JSON
Introduce a syntax error:
- Remove a closing brace
- Expected: ❌ AI Data Checker reports error

### Test Case 3: Security Warning
Add a sensitive field:
- Add `"password": "test"` to config
- Expected: ⚠️ Warning about sensitive field name

### Test Case 4: Workflow Best Practices
Modify `sample-workflow.yml`:
- Use unpinned action version (@main)
- Expected: ⚠️ Warning to pin to specific version

## Benefits of AI Bots

- **Automated validation**: Catch errors before they reach production
- **Security scanning**: Identify potential security issues
- **Best practices**: Learn and apply GitHub Actions best practices
- **Debugging assistance**: Get help when workflows fail
- **Time savings**: Reduce manual code review time

## Learning from AI Bots

The AI bots provide educational feedback:
- Security recommendations
- Performance tips
- Code quality suggestions
- Best practice guidelines

Use this feedback to improve your development skills and repository quality.
