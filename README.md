# aws-nuke wrapper script
A simple wrapper script over [aws-nuke](https://github.com/rebuy-de/aws-nuke) by [rebuy-de](https://github.com/rebuy-de)

## Prerequisites
- awscli
- docker

## Usage
**Must have credentials setup in `~/.aws`**

This script is designed to quickly factory reset test aws accounts.

### Command usage
```
Usage:
    aws-nuke.sh <profile> <region> [options]

Options:
    --no-dry-run    You need to add --no-dry-run to actually delete resources
```

## Example
```bash
# You may need this step:
aws iam create-account-alias --profile default --account-alias abcdeftesting123-account
chmod +x aws-nuke.sh
# Review what needs deleted on region eu-west-2 for default profile
./aws-nuke.sh default eu-west-2
# Confirm && delete
./aws-nuke.sh default eu-west-2 --no-dry-run
```
