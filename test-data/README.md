# Test Data for Checkpoints

This directory contains dummy data and service account configurations for simulated workflow execution and testing.

## Files

### `dummy-service-accounts.json`
Contains simulated service account configurations including:
- Service account identities (IDs, names, emails)
- Permission sets for different service types
- Dummy API credentials for testing

**⚠️ Important**: All credentials in this file are DUMMY values for testing purposes only. They are not real secrets and cannot be used for actual authentication.

### `dummy-workflow-data.json`
Contains test scenarios and dummy data for workflow validation:
- Test scenario definitions with expected outcomes
- Dummy repository data for simulation
- Performance metrics for baseline comparison
- Cache configuration test data

## Usage

These files are used by the checkpoint workflows to:
1. Simulate realistic workflow execution without real credentials
2. Validate workflow behavior at each checkpoint
3. Test service account permission models
4. Verify caching and performance optimizations

## Security Note

All data in this directory is for **testing and simulation purposes only**. No real credentials, secrets, or sensitive data should ever be stored here.
